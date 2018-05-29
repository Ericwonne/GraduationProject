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
            if (Session["S_user"] != null)
            {
                if (((User)Session["S_user"]).RegistryType == 'T')
                {
                    return RedirectToAction("TeacherMainPage");
                }
                else if (((User)Session["S_user"]).RegistryType == 'S')
                {
                    return RedirectToAction("StudentMainPage");
                }
                else
                {
                    return RedirectToAction("AdminMainPage");
                }
            }
            else
            {
                return View();
            }
        }

        [HttpGet]
        public object LoginTypeCheck()
        {
            return RedirectToAction("Login");
        }

        [HttpPost]
        public object LoginTypeCheck(FormCollection fc)
        {
            User user = null;
            if (Session["S_user"] != null)
            {
                user = (User)Session["S_user"];
            }
            else
            {
                user = new User
                {
                    UniqueClientID = fc["Uid"],
                    Username = fc["inputEmail"],
                    Password = fc["inputPassword"]
                };
                user.RegistryType = user.UniqueClientID[1];
                Session["S_user"] = user;
            }

            if (user.RegistryType == 'S')
            {
                return Redirect("StudentMainPage");
            }
            else if (user.RegistryType == 'T')
            {
                return Redirect("TeacherMainPage");
            }
            else
            {
                return Redirect("AdminMainPage");
            }

        }

        public ActionResult Register()
        {
            return View();
        }

        [CookieFilter]
        public ActionResult AdminMainPage()
        {
            DataTable teacher = DBManip.GetTeacherTable(),
                             student = DBManip.GetStudentTable(),
                             course = DBManip.GetAllCourses();

            //此处注意：DataSet的Add()方法不能添加两个没有命名的DataTable；见下网址：
            //https://www.cnblogs.com/chenhuzi/archive/2010/11/02/dataset-add-more-table-example.html

            DataSet set = DBManip.GetInfo();
            student.TableName = "student";
            set.Tables.Add(student.Copy());

            teacher.TableName = "teacher";
            set.Tables.Add(teacher.Copy());

            course.TableName = "AllCourses";
            set.Tables.Add(course.Copy());

            return View(set);
        }

        [HttpGet]
        [CookieFilter]
        public ActionResult TeacherMainPage()
        {
            ViewData["V_uname"] = DBManip.GetUser(((User)Session["S_user"]).UniqueClientID);
            DataSet set = DBManip.GetCourseOfTeacher(((User)Session["S_user"]).UniqueClientID);
            return View(set);
        }

        [HttpPost]
        public object TeacherMainPage(FormCollection fc)
        {
            User user = (User)Session["S_user"];
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
            return Redirect("TeacherMainPage");
        }

        [HttpGet]
        [CookieFilter]
        public ActionResult StudentMainPage()
        {
            ViewData["V_uname"] = DBManip.GetUser(((User)Session["S_user"]).UniqueClientID);
            DataSet set = DBManip.GetCourseOfStudent(((User)Session["S_user"]).UniqueClientID);
            return View(set);
        }

        [HttpPost]
        public object StudentMainPage(FormCollection fc)
        {
            User user = (User)Session["S_user"];
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
            return Redirect("StudentMainPage");
        }

        [CookieFilter]
        public ActionResult DisplayUsers()
        {
            if (((User)Session["S_user"]).RegistryType != 'A')
            {
                return Redirect("MainPage");
            }
            DataTable table = DBManip.GetUserTable();

            return View(table);
        }

        [CookieFilter]
        public ActionResult DisplayTeachers()
        {
            DataTable table = DBManip.GetTeacherTable();

            return View(table);
        }

        [CookieFilter]
        public ActionResult DisplayStudents()
        {
            DataTable table = DBManip.GetStudentTable();

            return View(table);
        }

        [HttpGet]
        public ActionResult AddStudent()
        {
            //404 not found
            return PartialView("FoF");
        }

        [HttpPost]
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
            Session["S_user"] = student;
            return View();
        }

        [HttpGet]
        public ActionResult AddTeacher()
        {
            //404 not found
            return PartialView("FoF");
        }

        [HttpPost]
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
            Session["S_user"] = teacher;
            return View();
        }

        public ActionResult SpecificUser(string id)
        {
            string[] jsonResult = DBManip.GetSpecificUser(id).Split('&');
            return View(jsonResult);
        }

        public object GetSpecificUser(string id)
        {
            string data = DBManip.GetSpecificUser(id);
            return data;
        }

        [HttpPost]
        public object ModifySpecificUser(FormCollection fc)
        {
            string[] arraydata = fc["ajaxData"].ToString().Split('&');
            string tableName = arraydata[0][1] == 'S' ? "student_information" : "teacher_information";

            string cmdTxt = "update " + tableName + " set ", tmp = "";
            //From one
            for (int i = 1; i < arraydata.Length; i++)
            {
                tmp += arraydata[i] + ',';
            }

            tmp = tmp.Substring(0, tmp.Length - 1);    //除掉最后的‘,’号
            cmdTxt = cmdTxt + tmp + " where uniqueClientID='" + arraydata[0] + "'";
            int rowAffected = DBManip.ModifyDBwithSQL(cmdTxt);

            if (rowAffected == 0)
            {
                return PartialView("Error");
            }
            return Redirect("DisplayUsers");
        }

        //[CookieFilter]        //Not yet perceived how it worked.
        public object MainPage()
        {
            if (Session["S_user"] != null)
            {
                if (((User)Session["S_user"]).UniqueClientID[1] == 'T')
                {
                    return RedirectToAction("TeacherMainPage");
                }
                else if (((User)Session["S_user"]).UniqueClientID[1] == 'S')
                {
                    return RedirectToAction("StudentMainPage");
                }
                else
                {
                    return RedirectToAction("AdminMainPage");
                }
            }
            else
            {
                return RedirectToAction("Login");
            }
        }

        public object CheckExist(string email, string passwd)
        {
            User user = new User
            {
                //unknown which type
                Username = email,
                Password = passwd
            };
            bool Existence = DBManip.CheckUserExistence(ref user, true);
            Session["S_user"] = user;
            if (Existence == false)
            {
                return Content("N");
            }
            else
            {
                return Content(user.UniqueClientID);
            }
        }

        public object LoadDenpendencies()
        {
            return DBManip.LoadDenpendencies();
        }

        public object ModifyMultipleUsers(FormCollection fc)
        {
            if (fc["cmdTxt"] == null)
            {
                return null;
            }
            int rowAffected = DBManip.ModifyDBwithSQL(fc["cmdTxt"].ToString());
            if (rowAffected == 0)
            {
                return PartialView("Error");
            }
            return Redirect("AdminMainPage");
        }

        public object ModifySpecificCourse(FormCollection fc)
        {
            if (fc["cmdTxt"] == null)
            {
                return null;
            }
            int rowAffected = DBManip.ModifyDBwithSQL(fc["cmdTxt"].ToString());
            if (rowAffected == 0)
            {
                return PartialView("Error");
            }
            return Redirect("AdminMainPage");
        }
    }
}