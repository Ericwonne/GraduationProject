using System.Web;
using System.Web.Mvc;

namespace GradutionProject
{
    internal class CookieFilter : FilterAttribute, IActionFilter
    {
        public CookieFilter()
        {
        }

        void IActionFilter.OnActionExecuted(ActionExecutedContext filterContext)
        {

        }

        void IActionFilter.OnActionExecuting(ActionExecutingContext filterContext)
        {
            //HttpContext.Current.Session
            if (filterContext.HttpContext.Session["S_user"] != null)
            {
                char loginType = ((Models.User)filterContext.HttpContext.Session["S_user"]).RegistryType;
                if (loginType == 'S')
                {
                    new RedirectResult("~/Views/Users/StudentMainPage");
                }
                else if (loginType == 'T')
                {
                    new RedirectResult("~/Views/Users/TeacherMainPage");
                }
                else
                {
                    new RedirectResult("~/Views/Users/AdminMainPage");
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("https://www.baidu.com");
            }

        }
    }
}