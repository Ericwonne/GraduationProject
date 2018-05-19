using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GradutionProject.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            bool iflogged = false;
            if (Session["S_user"] != null)
            {
                iflogged = true;
            }
            return View(iflogged);
        }

        public object IfLogged()
        {
            if (Session["S_user"] != null)
            {
                return null;
            }
            return Content("N");
        }
        public object Logout()
        {
            //HttpCookie CookieMessage;
            //string cookieName;
            //for (int i = 0; i < Request.Cookies.Count; i++)
            //{
            //    cookieName = Request.Cookies[i].Name;
            //    CookieMessage = new HttpCookie(cookieName)
            //    {
            //        Expires = DateTime.Now.AddDays(-1)
            //    };
            //    Response.Cookies.Add(CookieMessage);
            //}
            Session.Clear();
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Everyday()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult Test()
        {
            return View();
        }
        public ActionResult Test1()
        {
            return View();
        }
        public JsonResult AjaxTest()
        {
            bool result = true;
            return Json(result);
        }
        public JsonResult CheckUsernameTest(string name)
        {
            bool result = true;

            if (name == "admin")
            {
                result = false;
            }
            return Json(result);
        }
    }
}