public with sharing class AddPrimaryContact implements Queueable {
    private Contact primaryContact;
    private String state;
    
    public AddPrimaryContact(Contact ctc, String state) {
        this.primaryContact = ctc;
        this.state = state;
    }

    public void execute(QueueableContext qc) {
        List<Contact> toInsert = new List<Contact>();
        for (Account a : this.getTwoHundredAccounts()) {
            Contact clonedContact = this.primaryContact.clone();
            clonedContact.AccountId = a.Id;
            toInsert.add(clonedContact);
        }
        Database.insert(toInsert, false, AccessLevel.USER_MODE);
    }

    public List<Account> getTwoHundredAccounts() {
        String state = this.state;
        return [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
    }
}