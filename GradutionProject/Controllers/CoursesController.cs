using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Mvc;
using GradutionProject.Models;

namespace GradutionProject.Controllers
{
    public class CoursesController : Controller
    {
        // GET: Courses
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddCourses()
        {

            DataTable
                //building = DBManip.GetBuildingList(), 
                subject = DBManip.GetSubjectList(),
                room = DBManip.GetRoomList(),
                faculty = DBManip.GetFacultyList();
            DataSet set = new DataSet();
            //building.TableName = "BuildingList";
            //set.Tables.Add(building.Copy());

            subject.TableName = "SubjectList";
            set.Tables.Add(subject.Copy());

            room.TableName = "RoomList";
            set.Tables.Add(room.Copy());

            faculty.TableName = "Faculty";
            set.Tables.Add(faculty.Copy());

            return View(set);
        }
        [HttpPost]
        public object AddCourse(FormCollection fc)
        {
            //未设置重复添加课程的检测，只有此处Session用作判断，但没什么实质作用
            if (Session["S_if_added_this_course"] == null || Session["S_if_added_this_course"].ToString() == "no")
            {
                Session["S_if_added_this_course"] = "yes";
            }
            else
            {
                Session["S_if_added_this_course"] = "no";
                return "You have added this course";
            }
            Course course = new Course
            {
                CourseName = fc["courseName"],
                StartDate = fc["startDate"],
                EndDate = fc["endDate"],
                Venue = fc["venue"],
                Period = fc["period"],
                CourseInfo = fc["courseInfo"],
                CourseType = fc["subject"],
                Faculty = fc["faculty"],
                Capacity = fc["capacity"]
            };
            Exam exam = new Exam
            {
                ExamDate = fc["examPeriod"],
                ExamVenue = fc["examVenueClass"],
                ExamDuration = fc["examDuration"],
                ExamType = fc["examType"] == "open" ? ExamType.开卷.ToString() : ExamType.闭卷.ToString()
            };

            //此处问题：不能强制将User转为Teacher类型
            //【未解决】
            User teacher = (User)Session["S_user"];
            course.CourseTeacher = teacher.UniqueClientID;
            DBManip.AddCourse(course, exam);

            return "Error";
        }

        [CookieFilter]
        public object DisplayCourses()
        {
            string studentID = ((User)Session["S_user"]).RegistryType == 'S' ? ((User)Session["S_user"]).UniqueClientID : "";
            //string studentID = ((User)Session["S_user"]).UniqueClientID;
            DataSet set = DBManip.GetCourseTable(studentID);
            ViewData["browseType"] = studentID;
            return View(set);
        }

        [CookieFilter]
        public ActionResult SpecificCourse(string id, string state)   // id = courseID; state = selected/not selected
        {
            if (id == null)
            {
                return Redirect("MainPage");
            }
            else if (id.Length != 10)
            {
                return PartialView("FoF");
            }

            //tc = teacher_course_information
            DataSet tc = DBManip.GetCourseInfo(id);
            Session["S_courseid"] = id;
            ViewData["V_uid"] = ((User)Session["S_user"]).UniqueClientID;   //stduent id
            switch (state)
            {
                //Only three situations: select/collect/both
                case "A":
                case "B":
                case "C":
                case "N":
                    break;
                default: state = ""; break;
            }
            //Session["S_state"] = state;
            //本来使用的是ViewData["V_state"] = state; 但现在似乎两者没什么区别：因为这里TempData并不能跨Action传值。
            TempData["T_state"] = state; //Original: Session["S_state"];

            return View(tc);
        }

        public ActionResult MyCourse(string id)  // id = courseID
        {
            DataSet tc = DBManip.GetCourseInfo(id);
            ViewData["V_uid"] = ((User)Session["S_user"]).UniqueClientID;   //teacher id
            return View(tc);
        }

        public object ChooseCourse()
        {
            //Session["S_courseid"] selected course id : String()
            //Session["S_student"]  the info of the one who select : User()

            string selectedCourseId = Session["S_courseid"].ToString();
            string selectedBy = ((User)Session["S_user"]).UniqueClientID;
            char selectType = 'A';//which means Choose course

            DBManip.SelectCourse(selectedBy, selectedCourseId);

            return selectType;         // Chosen
        }

        public object CollectCourse()
        {
            string selectedCourseId = Session["S_courseid"].ToString();
            string selectedBy = ((User)Session["S_user"]).UniqueClientID;
            char selectType = 'B';//which means Choose course

            DBManip.SelectCourse(selectedBy, selectedCourseId, selectType);

            return selectType;         //Collected
        }

        public object UnchooseCourse()
        {
            //if (Session["S_state"].ToString() == "C")
            //{
            //    //TempData["T_state"] = "B";
            //    Session["S_state"] = "B";
            //}
            //else
            //{
            //    Session["S_state"] = "";
            //}

            string selectedCourseId = Session["S_courseid"].ToString();
            string selectedBy = ((User)Session["S_user"]).UniqueClientID;
            char selectType = 'a';//which means Choose course

            DBManip.DeselectCourse(selectedBy, selectedCourseId);

            return selectType;         //Unchosen
        }

        public object UncollectCourse()
        {
            //if (Session["S_state"].ToString() == "C")
            //{
            //    //TempData["T_state"] = "A";
            //    Session["S_state"] = "A";
            //}
            //else
            //{
            //    Session["S_state"] = "";
            //}
            string selectedCourseId = Session["S_courseid"].ToString();
            string selectedBy = ((User)Session["S_user"]).UniqueClientID;
            char selectType = 'b';//which means Choose course

            DBManip.DeselectCourse(selectedBy, selectedCourseId, selectType);


            return selectType;         //Uncollected
        }

        public object ValidateVenuePeriod(string json)
        {
            if (json == "" || json.Contains('_') == false)
            {
                return PartialView("FoF");
            }
            else
            {
                string[] para = json.Split('_');    //[0] venue  [1] period
                if (para.Length != 2)
                {
                    return PartialView("FoF");
                }
                else
                {
                    string result = DBManip.IfConflicted(para[0], para[1]);
                    if (result == "false")
                    {
                        return Content("false");
                    }
                    else
                    {
                        return Content(result);
                    }
                }
            }
        }

        public object ValidateVenuePeriodForStudent(string json)
        {
            if (json == "" || json.Contains('_') == false)
            {
                return PartialView("FoF");
            }
            else
            {
                string[] para = json.Split('_');    //[0] period  [1] studentID
                if (para.Length != 2)
                {
                    return PartialView("FoF");
                }
                else
                {
                    bool result = DBManip.IfConflictedStudent(para[0], para[1]);
                    if (result == false)
                    {
                        return Content("false");
                    }
                    else
                    {
                        return Content("true");
                    }
                }
            }
        }
    }
}