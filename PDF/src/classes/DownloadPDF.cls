/**
 * Created by melissaderricott on 10/9/19.
 */

@RestResource(urlMapping='/LLPDF/*')

    global class DownloadPDF {
            @HttpGet
            global static void getPDF() {
                RestRequest req = RestContext.request;
                // if your URL is http://<org>/HouseholdPDF?Id=12345
                String Id = RestContext.request.params.get('Id') ;
                RestResponse res = RestContext.response;
                //res.addHeader('Content-Type','pdf');
                res.addHeader('Content-Type','application/pdf');
//                res.addHeader('Content-Type','text/plain');
                //String pdfAsBase64; // retrieve base64 using the ID
                res.responseBody = EncodingUtil.base64Decode(pdf);
                //res.responseBody = pdf;
            }

        public static string pdf{
            get {
                //public static String match1() {
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                String q = '\'';
                String endpoint = 'https://lldev.apimanagement.us3.hana.ondemand.com/ZRETRIEVE_LLIS_FORMS_SRV/getForms?SRId=' + q + '8000000660' + q + '&SRType=' + q + 'Assess' + q;
                request.setEndpoint(endpoint);
                request.setMethod('GET');
                request.setHeader('Authorization', 'Bearer Xo19BeCrVV9OF3R0nVAqkatt0Z16');
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
//                        String s = properties.getChildElement('Document', null).getText();
//                       System.debug(s);
//                        if(properties.getName() == 'Document'){
//                            String docu = properties.getAttributeValue('Document',null);
//                            docs.add(docu);
                        }
                    }

                }
//System.debug('PDF: ' + f);


                return docs[0];
            }
            set;
        }


}

        //public String getMatch1() {

//
//            string s = 'JVBERi0xLjYNJeLjz9MNCjc2NyAwIG9iag08PC9GaWx0ZXIvRmxhdGVEZWNvZGUvRmlyc3QgMTY3Ni9MZW5ndGggMjQwNC9OIDIwMC9UeXBlL09ialN0bT4' +
//                    '+c3RyZWFtDQpo3pRZXYtcNxL9K4J9sZ9GJan0ASEwZCa7Q+zxMDNhF5oQvN7GBBxPMJNl8+/' +
//                    '3HEn3TrtvS6ZfWpd7VUf1capKUquxJpqcTDLi8WAkeSNiXFAjzrgS8d54L0aC8YrvanyxRqIJDlOSCQlDNmqBUIwGCFmjsRgnJlogOROB7LyJOQDXJMhCNCm' +
//                    '+RZNSNi6ZLNa4bLJPWNPkjFWsKUDCyiUk450pqUARI9ZCCvpYaJMclLXOVKUBmAJGIFInBzMS1HeBq2AsmAcDPBcvGNWZDEs8Fsu0D6tl4IUYoAfGArWAp' +
//                    '+oNpohicgZehEPgMIlQLQMvRvgNeAkm0DMpJlOAl6EXlpQcsinAK/' +
//                    'BQAV6BiwrwCj7Cvc6qwja4C54qcIYE4NB9VN7CLc7xgZ7kMkB1ns62Hg8BgBZu9dTIKvwb6CLABtqGeU7hV7EA1ioO5EhAOjzCfx7SCaZ4CCfMYKwywsRIZLjUQzLDDx6CBRGGdmCFNwEKlUIaIFSQx7qeI' +
//                    'YFG3sJ+EMgLFoL3vWCdGkRoCG8gAsEELOXgd7WkVzBcygMUUfEecYTXfYDVmOoDlISXfACtFHhKwgFPIYQlwctolKojNBF4EYtG4EXwIgIvwSFQ2SeARJqGOEfgZbAZ0fMZvELUfIZwBF5mvEAfX/' +
//                    'AjyANfoK4wE8hCgbpQrXIOfrAkIR1BRzMjHHQTqBgceUCfwXIQ0OIB5oCZeCBlEfEQKI7sQOAqWfGgZC+QA' +
//                    '+lHF9JeQZYE9SQykDVyMpCjJYWBHIWcBnIMleR4IJthWUhwo8CFIXlOBnKCF5jvIZHpAA3FUhzIxVMcyIXJhWirpTgjYyGKNMEDrUDA1dZEYfBgtyDkSlSkEB4iJyc8gMwCndTRCvhRHV4L4q6MP9NWPa1A' +
//                    '5NXDJkHo1SNeoqQBrYBHNDAWiL4G1ia4WJmpSEtQg3mn5AadEFl/gIFMxQPFwQFl2UHO4oFWQFKrE6ClplLTGFSiFSCC5sDJQM7MIrIu04oE5MIoo/' +
//                    '5oASqJrYVWkGlWmP4BD0xL1KBoaQXyOFpWAlShyHiyQkV6S0Cm6FItFiAonQCsiDzAQ62bEIeLI2jHQgLy0opMFlMctI' +
//                    '+BhET2x0ArUJCiOk4GMtzBsoMHWgEuxsgoQ5UYWSbAchQvx5KEB3IVdQk1gcUJyIlWYOGYyFWgx1yLPJCzY+ECclHWeyAXWOFYiS1LFmpTsqwsqE3JIhbM/GQzJ7N6swUAK5GMDrUpMSDffXfxE5qRNfcXd' +
//                    '++/7D8/P37Z71HS9ejV7f5/zz/t/zLu4v7p0/7t+z9Q7n2d8/jXH/uLh+cvf36oE++fnp6//56wu8TvDCfHXy7evP/88dX+8+uLO9PQHy6unj78+TtWaAImt0W7Pg9Y/uP' +
//                    '+4vEVByOvO2qpqOAlB5jLIbaXSfq3NrpU2sp3JnXEh/2HRTtUmDo5t7kNyK0SuUs8vv/3p/0i4puILpPaQpx1302Q0G1o8Px01T9Zvm0+u/sIFy8r3C3osaGnFf0I4vLT86sffn54/PXy6ur++uHhNUAd5' +
//                    '+kQ1Mj8+06a55yMTUIJ7SblY5M835Yxums+dn5FzwOTrt9e3ryhQYpZTZvTBoX5953THvuJQZ3vPeiHBkW+nbjT5YHoasjdP97dXtOQxFlprKi3jcFurKiXZbVyrGjGW2/Hino/' +
//                    'EH0h0ZsDZQvh3FjZ1AKZWwKUOMuS1CalFojU8ivbNRU3ZqYlZ9ImZ4RJkyZJk1rSpDXc6UTS3Nz9env5thoqTJg0Sxj5xoRUxtoyH1Iea5tbYcruW9q+q7oyF/IkyBLmE3a5VbXcnJRbQS6NeMWPI5K7/' +
//                    'T3gX9nIFMlhtOYJkV3uFHiprX5r9VoAhNTOw8S5xPmiafe1VBpI/fj05felczTvFzfTo6aE' +
//                    '+VutrSRfsTNNwqrJgZyUgdyhLi0yRWe6IEXNoT7kbvEzffyqz7GsDGQPder8aOHi6aeNvVFa7WMeEeeuV4bD4Jfer+1aAI7nUFu0s5ur69vHm8saTUdilzyz1K2WHsv6gexq6Sk1ebJreoaZnrfX/' +
//                    '6xrMAm6Y0YKyqrgIqQjoYMY8BjZ9EgzPa7/dfPweHP794qbK67OlLEvGXMomUaSX2m07Li+EcHbxxYAXzc6dhY9LQfRW+RcGckdaOMbCUPjZuhbzDZEN2tLvjnWr+z1YdNve/' +
//                    '0wXjc7HeaPj5N23rwUVicdY9DYh8d397UNeZLU50n/dvMJu9CyMoSxOWHZAwTZmMMEC5OGH7qf105/' +
//                    'jLHuI1qv8syIECYG6XzCrr3g1UQdmnk6M29pxCFtzCOxw8S9KmNZppNOuq76sSwprBO3anOrvrg1bd36iLPWj7/tP/3H0bOBzNOJZ4OdT9hp82y0Y1/' +
//                    'q4kvd2BTIRJ34MspYljSPkw1Ka1imdXReC9VhkqJx2SvGze4rkNPRj3cmW5GYxmjka4xnoO1kOVJKOC5EL+fOeqPVz1Prjv/qt/8uy9bOIhMKifQ' +
//                    '+3Aua9OonfactZTnS9bFXJqfl5aQhp063ywG0H4mlHfzq1Vkbe4vsZ2Vxfb7rCrjeKPrJRnx3h+9y/uDcvAmsSFrdsqm' +
//                    '+oTYqibNte5mI1w4peRzME0Li3ASx9qrxOXSAqGNErV3ThTMR8wSxnv3HR9DTiOuZ8xRivW0YHzsHiGGCWG8QvD8HcSe+E64zW/puQHpPlNAJ2puY9G2C9BYjvceIdjld7nW63Et5PkVUv/' +
//                    'rcx409ob5PszObnYjXLaIvE3dshWTt86cQaz0Zd/oBYpwg1lwMeiZimSDW9Az5PER1E8SanipnIuoYMdb01HAO4k5655XYCRc7QXvbk973pDc' +
//                    '+icv8TuzlQrNfv0jqBO13K5LSjKhrU5dtZ47tYnDS1mXt66fEayWIs0qwFZK1eZ9CrJVg1r5PIqYJYs3FWQs/hZjsBLGmZyxnIvoJYk3P5M5EjBPEmp5Jz0HcSeqE6xdU0i/' +
//                    '6pF8gSb9Bkn6FJLnP73dJUjpBS5crnaCly5U8I2pefZ42V8yxFodUJkTNbiJeK0GeVYKtkKz3Xyc+ploJZjdgJxHzBLHmYk7nIRaZINb0LPZMxDBBbFf9/kzENEGs6VniOYg7166R6t9fbfR97P/';
//            return EncodingUtil.base64Decode(s).toString();


//
//// Option 2: use an example PDF document from a URL,
//// in this case: http://www.africau.edu/images/default/sample.pdf
//// In Setup, add the endpoint to Remote Site Settings
//
//// @future(callout=true) (I didn't need this line to get it to work)
//        public String getMatch2() {
//            Http httpProtocol = new Http();
//            HttpRequest request = new HttpRequest();
//            String endpoint = 'http://www.africau.edu/images/default/sample.pdf';
//            request.setEndPoint(endpoint);
//            request.setMethod('GET');
//            HttpResponse response = httpProtocol.send(request);
//            return response.getBody();
//        }
   // }
