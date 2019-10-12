/**
 * Created by melissaderricott on 10/9/19.
 */

@RestResource(urlMapping='/LLPDF/*')

    global class  DownloadPDF {
            @HttpGet
            /**
             * Create Sites page using PDF blob
             */
            global static void getPDF() {
                RestRequest req = RestContext.request;
                String SRId = RestContext.request.params.get('SRId') ;
                String SRType = RestContext.request.params.get('SRType');
                RestResponse res = RestContext.response;
                res.addHeader('Content-Type','application/pdf');
                res.responseBody = EncodingUtil.base64Decode(pdf(SRType, SRId));
            }


    public static string bearer(){
        Http  http = new Http();
        HttpRequest request = new HttpRequest();
        String endpoint = 'https://lldev.apimanagement.us3.hana.ondemand.com:443/sap/opu/odata/sap/oAuthService/GenerateToken';
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Accept','application/json');
        String tokenPostBody = 'client_id=I4JVgJgLlJGAkhArxvKIdmcZKnHffDuM&client_secret=TFKNe45hDYG6tNeq&grant_type=client_credentials';
        request.setBody(tokenPostBody);
        HttpResponse postResponse = http.send(request);
        //System.debug(postResponse.getBody());
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(postResponse.getBody());
        System.debug(results.get('access_token'));
        String token = results.get('access_token').toString();
        return token;

    }


//
//
//    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
//    //Cast the values in the 'animals' key as a list
//    List<Object> animals = (List<Object>) results.get('animals');
//    System.debug('Received the following animals:');
//    for (Object animal : animals){
//    System.debug(animal);


    /**
     * Retrieves the base64 data of the PDF
     *
     * @param SRType
     * @param SRId
     *
     * @return blob of PDF
     */
    public static  string pdf(String SRType, String SRId){
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                String endpoint = 'https://lldev.apimanagement.us3.hana.ondemand.com/ZRETRIEVE_LLIS_FORMS_SRV/getForms?SRId=' + SRId + '&SRType=' + SRType ;
                request.setEndpoint(endpoint);
                request.setMethod('GET');
                String bearer = 'Bearer ' + bearer();
                System.debug(bearer);
                request.setHeader('Authorization', bearer);
                HttpResponse response = http.send(request);
                Dom.Document doc = response.getBodyDocument();
                List<String> docs = new List<String>();
                for (Dom.XMLNode entry : doc.getRootElement().getChildElements()) {

                    for (Dom.XmlNode content : entry.getChildElements()) {

                        for (Dom.XmlNode properties : content.getChildElements()) {
                            for (Dom.XmlNode document : properties.getChildElements()) {
                                String s = properties.getChildElement('Document', 'http://schemas.microsoft.com/ado/2007/08/dataservices').getText();
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


