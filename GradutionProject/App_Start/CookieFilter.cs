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
            if (HttpContext.Current.Request.Cookies["User"] != null)
            {

                if (HttpContext.Current.Request.Cookies.Get("User").Values["uid"] != null)
                {

                    HttpCookie cookie = HttpContext.Current.Request.Cookies.Get("User");

                    filterContext.HttpContext.Session["uid"] = cookie.Values["uid"];
                }
            }

        }
    }
}