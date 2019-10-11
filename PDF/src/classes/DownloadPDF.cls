/**
 * Created by melissaderricott on 10/9/19.
 */

@RestResource(urlMapping='/LLPDF/*')

    global class DownloadPDF {
            @HttpGet
            global static void getPDF() {
                RestRequest req = RestContext.request;
                String SRId = RestContext.request.params.get('SRId') ;
                String SRType = RestContext.request.params.get('SRType');
                RestResponse res = RestContext.response;
                //res.addHeader('Content-Type','pdf');
                res.addHeader('Content-Type','application/pdf');
//                res.addHeader('Content-Type','text/plain');
                //String pdfAsBase64; // retrieve base64 using the ID
                res.responseBody = EncodingUtil.base64Decode(pdf(SRType, SRId));
                //res.responseBody = pdf;
            }




        public static  string pdf(String SRType, String SRId){
                //public static String match1() {
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                String endpoint = 'https://lldev.apimanagement.us3.hana.ondemand.com/ZRETRIEVE_LLIS_FORMS_SRV/getForms?SRId=' + SRId + '&SRType=' + SRType ;
                request.setEndpoint(endpoint);
                request.setMethod('GET');
                request.setHeader('Authorization', 'Bearer 8xzuHrgGT0iRj5ABhkIaWD3XfInc');
                HttpResponse response = http.send(request);
                Dom.Document doc = response.getBodyDocument();
                List<String> docs = new List<String>();
                for (Dom.XMLNode entry : doc.getRootElement().getChildElements()) {

                    for (Dom.XmlNode content : entry.getChildElements()) {

                        for (Dom.XmlNode properties : content.getChildElements()) {
                            for (Dom.XmlNode document : properties.getChildElements()) {
                                String s = properties.getChildElement('Document', 'http://schemas.microsoft.com/ado/2007/08/dataservices').getText();
                                //System.debug(properties.getChildElement('Document', 'http://schemas.microsoft.com/ado/2007/08/dataservices').getText());

                                docs.add(s);
                            }

                        }
                    }

                }
            String result;
            for (String base64 : docs){
               result += base64 + '\n';
            }


            return result;
            }
        }


