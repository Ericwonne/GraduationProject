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
            return View();
        }

        public object LoginTypeCheck(FormCollection fc)
        {
            User student = new User
            {
                Username = fc["inputEmail"],
                Password = fc["inputPassword"],
                RegistryType = 'S'
            };
            User teacher = new User
            {
                Username = fc["inputEmail"],
                Password = fc["inputPassword"],
                RegistryType = 'T'
            };
            bool TExistence = DBManip.CheckUserExistence(ref teacher);
            bool SExistence = DBManip.CheckUserExistence(ref student);
            if (TExistence == false && SExistence == false)
            {
                return "User doesn't exist";                                // This means user not exist
            }
            if (TExistence == true && SExistence == true)
            {
                return "We are sorry to provide you with System Error 2100";
            }
            if (SExistence == true)
            {
                Session["S_student"] = student;
                return Redirect("StudentMainPage");
            }
            else if (TExistence == true)
            {
                Session["S_teacher"] = teacher;
                return Redirect("TeacherMainPage");
            }
            else
                return null;
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
    }
}