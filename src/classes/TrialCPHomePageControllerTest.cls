@isTest
private class TrialCPHomePageControllerTest 
{
  static testMethod void testTrialCPHomePageController() 
  {
      TrialCustomerPortalHomePageController testController = new TrialCustomerPortalHomePageController();
      try
      {
          testController.SortProducts();
      }
      catch(Exception ex){}
      try
      {
          testController.SortCases();
      }
      catch(Exception ex){}
      try
      {
          testController.SortSolutions();
      }
      catch(Exception ex){}
      try
      {
          testController.SortIdeas();
      }
      catch(Exception ex){}
  }
}