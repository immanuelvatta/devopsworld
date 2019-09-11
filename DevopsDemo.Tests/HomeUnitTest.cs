using DevopsDemo.Client.Controllers;
using Microsoft.AspNetCore.Mvc;
using Xunit;

namespace DevopsDemo.Tests
{
  public class HomeUnitTest
  {
    [Fact]
    public void Test_Index()
    {
      //testing if the method works
      var sut = new HomeController(); //sut = subject under test
      var view = sut.Index();  
      Assert.NotNull(view);
      Assert.IsType<ViewResult>(view);
    }
    [Fact]
    public void Test_Privacy()
    {
      var sut = new HomeController();
      var view = sut.Privacy();
      Assert.NotNull(view);

    }
      
  }
}