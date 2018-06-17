public class ChatterAnswers {
    public String createAccount(String firstname, String lastname, Id siteAdminId) {
        Account a = new Account(name = firstname + ' ' + lastname, ownerId = siteAdminId);
        a.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        insert a;
        return a.Id;
    }
}