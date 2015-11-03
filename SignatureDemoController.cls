public class SignatureDemoController{
    public String initial1{get;set;}
    public String initial2{get;set;}
    public SignatureDemoController(){
        String temp = ApexPages.currentPage().getParameters().get('dId');
        if( temp != null){
            list<String> docIds = temp.split(',');
            initial1 = docIds[0];
            initial2 = docIds[1];
        }
    }
    public PageReference submit(){
    
        Folder f1 = [SELECT Id FROM Folder WHERE Name='Signatures' LIMIT 1];
        
        List<string> strList = new List<string>();
        strList=initial1.split(',');
        Document d1 = new Document(Name = 'Initial1', FolderId = f1.Id);
        if(strList.size()>1){
                d1.body=EncodingUtil.base64Decode(strList[1]);
            }    
            else if(strList.size() >0){
                d1.body=EncodingUtil.base64Decode(strList[0]);
            } 
        Upsert d1;
        strList=initial2.split(',');
        Document d2 = new Document(Name = 'Initial2', FolderId = f1.Id , contentType = 'image/jpeg');
        if(strList.size()>1){
                d2.body=EncodingUtil.base64Decode(strList[1]);
            }    
            else if(strList.size() >0){
                d2.body=EncodingUtil.base64Decode(strList[0]);
            } 
        Upsert d2;
        return (new PageReference('/SignatureDemoPdf?dId=' + d1.Id + ',' + d2.Id )).setRedirect(true);
    }
}
