using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Mvc;
using GradutionProject.Models;

namespace GradutionProject.Controllers
{
    public class UsersController : Controller
    {
        // GET: Users
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Login()
        {
            //【未解决】该页面存在一个问题：使用浏览器的回退（Back）则会清除Session。
            if (Session["S_teacher"] != null && Session["S_teacher"].ToString() != "")
            {
                return RedirectToAction("TeacherMainPage");
            }
            else if (Session["S_student"] != null && Session["S_student"].ToString() != "")
            {
                return RedirectToAction("StudentMainPage");
            }
            else
                return View();
        }

        public object LoginTypeCheck(FormCollection fc)
        {
            User user = new User
            {
                //unknown which type
                Username = fc["inputEmail"],
                Password = fc["inputPassword"]
            };

            //if (fc["remember"].ToString() == "checked")
            //{
            //    HttpCookie cookie = new HttpCookie("User")
            //    {
            //        Expires = DateTime.Now.AddMonths(1)
            //    };
            //    cookie["uid"] = fc["inputEmail"];
            //    Response.Cookies.Add(cookie);
            //}

            bool Existence = DBManip.CheckUserExistence(ref user, true);
            if (Existence == false)
            {
                return "User doesn't exist";                                // This means user not exist
            }
            else if (Existence == true && user.RegistryType == 'S')
            {
                Session["S_student"] = user;
                return Redirect("StudentMainPage");
            }
            else if (Existence == true && user.RegistryType == 'T')
            {
                Session["S_teacher"] = user;
                return Redirect("TeacherMainPage");
            }
            else
                return "We are sorry to provide you with System Error 2100";
        }

        public ActionResult Register()
        {
            return View();
        }

        [HttpGet]
        public ActionResult TeacherMainPage()
        {
            ViewData["V_uname"] = DBManip.GetUser(((User)Session["S_teacher"]).UniqueClientID);
            ViewData["V_courseChosen"] = "";
            DataSet set = DBManip.GetCourseOfTeacher(((User)Session["S_teacher"]).UniqueClientID);
            return View(set);
        }

        [HttpPost]
        public object TeacherMainPage(FormCollection fc)
        {
            User user = (User)Session["S_teacher"];
            Teacher teacherInfo = new Teacher
            {
                UniqueClientID = user.UniqueClientID,
                Name = fc["name"],
                Gender = Convert.ToChar(fc["gender"]),
                Age = Convert.ToInt32(fc["age"]),
                Wechat = fc["wechat"],
                QQ = fc["qq"],
                Phone = fc["phone"],
                University = fc["university"],
                Position = Convert.ToChar(fc["position"]),
                College = fc["college"],
                Major = fc["major"],
                WorkNo = fc["workNo"],
                WorkPass = fc["workPass"]
            };
            DBManip.AddUser(user, teacherInfo);
            ViewData["V_uname"] = teacherInfo.Name;
            return "已经成功注册！";
        }
        [HttpGet]
        public ActionResult StudentMainPage()
        {
            ViewData["V_uname"] = DBManip.GetUser(((User)Session["S_student"]).UniqueClientID);
            DataSet set = DBManip.GetCourseOfStudent(((User)Session["S_student"]).UniqueClientID);
            return View(set);
        }

        [HttpPost]
        public object StudentMainPage(FormCollection fc)
        {
            User user = (User)Session["S_student"];
            Student studentInfo = new Student
            {
                UniqueClientID = user.UniqueClientID,
                Name = fc["name"],
                Gender = Convert.ToChar(fc["gender"]),
                Age = Convert.ToInt32(fc["age"]),
                Wechat = fc["wechat"],
                QQ = fc["qq"],
                Phone = fc["phone"],
                Grade = fc["grade"],
                Position = Convert.ToChar(fc["position"]),
                College = fc["college"],
                Major = fc["major"],
                CardNo = fc["cardNo"],
                CardPass = fc["cardPass"]
            };
            DBManip.AddUser(user, studentInfo);
            ViewData["V_uname"] = studentInfo.Name;
            return "已经成功注册！";
        }

        public ActionResult DisplayUsers()
        {
            DataTable table = DBManip.GetUserTable();

            return View(table);
        }

        public ActionResult DisplayTeachers()
        {
            DataTable table = DBManip.GetTeacherTable();

            return View(table);
        }

        public ActionResult DisplayStudents()
        {
            DataTable table = DBManip.GetStudentTable();

            return View(table);
        }

        public ActionResult AddStudent(FormCollection fc)
        {
            User student = new User(fc["inputEmail"], fc["inputPassword"], 'S');
            bool existence = DBManip.CheckUserExistence(ref student);
            if (existence == true)
            {
                //User has been registered, do the re-register
                return Redirect("Register");
            }
            //DBManip.AddUser(student);
            Session["S_student"] = student;
            return View();
        }

        public ActionResult AddTeacher(FormCollection fc)
        {
            User teacher = new User(fc["inputEmail"], fc["inputPassword"], 'T');
            bool existence = DBManip.CheckUserExistence(ref teacher);
            if (existence == true)
            {
                //User has been registered, do the re-register
                return Redirect("Register");
            }
            //DBManip.AddUser(teacher);
            Session["S_teacher"] = teacher;
            return View();
        }

        public ActionResult SpecificUser(string id)
        {
            return View();
        }
        public object MainPage()
        {
            if (Session["S_teacher"] != null && Session["S_teacher"].ToString() != "")
            {
                return RedirectToAction("TeacherMainPage");
            }
            else if (Session["S_student"] != null && Session["S_student"].ToString() != "")
            {
                return RedirectToAction("StudentMainPage");
            }
            else
            {
                return RedirectToAction("Login");
            }
        }
        public object CheckExist(FormCollection fc)
        {
            //User user = new User
            //{
            //    //unknown which type
            //    Username = fc["inputEmail"].ToString(),
            //    Password = fc["inputPassword"].ToString()
            //};


            //bool Existence = DBManip.CheckUserExistence(ref user, true);

            return Content(fc["a"]);
        }
    }
}