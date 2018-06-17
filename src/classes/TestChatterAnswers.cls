@isTest 

private class TestChatterAnswers 
{ 
  static testMethod void runPositiveTestCases() 
  { 
    ChatterAnswers ca = new ChatterAnswers(); 
    ca.createAccount('Test', 'Last', userinfo.getuserid()); 
  } 
}