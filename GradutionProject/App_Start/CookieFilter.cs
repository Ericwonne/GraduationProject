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
                //char loginType = ((Models.User)filterContext.HttpContext.Session["S_user"]).RegistryType;
                //if (loginType == 'S')
                //{
                //    filterContext.HttpContext.Response.Redirect("StudentMainPage");
                //}
                //else if (loginType == 'T')
                //{
                //    filterContext.HttpContext.Response.Redirect("TeacherMainPage");
                //}
                //else
                //{
                //    filterContext.HttpContext.Response.Redirect("AdminMainPage");
                //}
            }
            else
            {
                filterContext.HttpContext.Response.Redirect("Login");
            }

        }
    }
}