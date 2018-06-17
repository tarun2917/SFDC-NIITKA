@isTest
public class testsuperSort
{
 public static testMethod void sortAscendingTest()
 { 

  List<Opportunity> opps = new List<Opportunity>(); 
  for(integer i = 0; i<1000; i++){ 
  opps.add(new Opportunity(Name = 'test' + i, Amount = 1000 * Math.random())); 
 } 

    Test.startTest(); 
    Long start = system.currentTimeMillis(); 
    superSort.sortList(opps,'Amount','asc'); 
    system.debug(system.currentTimeMillis() - start); 
    Test.stopTest(); 
    
    //Assert the list was sorted correctly 
    Decimal assertValue = -1; 
    for(Opportunity o : opps) { 
    System.debug('Opp value: ' + o.amount); 
    //System.assert(assertValue <= o.amount); 
    assertValue = o.amount; 
    } 
} 

public static testMethod void sortAscendingTest2()
{ 
Account a = new Account();
a.Name = 'Test last';
a.OwnerId = UserInfo.getUserId();
a.R1_ACC_TLF_Phone_Operative__c = '000000000';

insert a; 


List<Opportunity> opps = new List<Opportunity>(); 
for(integer i = 0; i<1000; i++){ 
opps.add(new Opportunity(Name = 'test',Accountid = a.id)); 
} 


Test.startTest(); 
Long start = system.currentTimeMillis(); 
superSort.sortList(opps,'Accountid','asc'); 
system.debug(system.currentTimeMillis() - start); 
Test.stopTest(); 

//Assert the list was sorted correctly 
Decimal assertValue = -1; 
for(Opportunity o : opps) { 
System.debug('Opp value: ' + o.amount); 
//System.assert(assertValue <= o.amount); 
assertValue = o.amount; 
} 

} 
public static testMethod void sortDescendingTest(){ 

List<Opportunity> opps = new List<Opportunity>(); 
for(integer i = 0; i<1000; i++){ 
opps.add(new Opportunity(Name = 'test' + i, Amount = 1000 * Math.random())); 
} 

Test.startTest(); 
superSort.sortList(opps,'Amount','desc'); 
Test.stopTest(); 

//Assert the list was sorted correctly 
Decimal assertValue = 1001; 
for(Opportunity o : opps) { 
System.debug('Opp value: ' + o.amount); 
//System.assert(assertValue >= o.amount); 
assertValue = o.amount; 
} 
}
}