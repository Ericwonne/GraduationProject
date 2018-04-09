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
                room = DBManip.GetRoomList();
            DataSet set = new DataSet();
            //building.TableName = "BuildingList";
            //set.Tables.Add(building.Copy());

            subject.TableName = "SubjectList";
            set.Tables.Add(subject.Copy());

            room.TableName = "RoomList";
            set.Tables.Add(room.Copy());


            return View(set);
        }
        public object AddCourse(FormCollection fc)
        {
            if (Session["S_if_added_this_course"].ToString() == null || Session["S_if_added_this_course"].ToString() == "no")
            {
                Session["S_if_added_this_course"] = "yes";
            }
            else
            {
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
                CourseType = fc["subject"]
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
            User teacher = (User)Session["S_teacher"];
            course.CourseTeacher = teacher.UniqueClientID;
            DBManip.AddCourse(course, exam);

            return "Error";
        }

        public object DisplayCourses()
        {
            string studentID = ((User)Session["S_student"]).UniqueClientID;
            DataSet set = DBManip.GetCourseTable(studentID);

            return View(set);
        }

        public ActionResult SpecificCourse(string id, string state)   // id = courseID; state = selected/not selected
        {
            //tc = teacher_course_information
            DataSet tc = DBManip.GetCourseInfo(id);
            Session["S_courseid"] = id;
            ViewData["V_state"] = state;
            return View(tc);
        }

        public object ChooseCourse()
        {
            //Session["S_courseid"] selected course id : String()
            //Session["S_student"]  the info of the one who select : User()

            string selectedCourseId = Session["S_courseid"].ToString();
            string selectedBy = ((User)Session["S_student"]).UniqueClientID;

            DBManip.SelectCourse(selectedBy, selectedCourseId);

            return "添加到课表成功！";
        }

        public object CollectCourse()
        {
            string selectedCourseId = Session["S_courseid"].ToString();
            string selectedBy = ((User)Session["S_student"]).UniqueClientID;
            char selectType = 'B';//which means Choose course

            DBManip.SelectCourse(selectedBy, selectedCourseId, selectType);

            return "您已收藏该课程";
        }
        public object UnchooseCourse()
        {
            return "您已从课表移除该课程";
        }
        public object UncollectCourse()
        {
            return "您已取消收藏该课程";
        }
    }
}