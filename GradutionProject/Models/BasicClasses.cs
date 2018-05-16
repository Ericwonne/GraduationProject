using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GradutionProject.Models
{
    public class User
    {
        public string UniqueClientID { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string RegistryDate { get; set; }
        public char RegistryType { get; set; }

        public User()
        {

        }
        public User(string username, string password, char registryType, string uniqueClientID = "", string registryDate = "")
        {
            //If not equal "" then data is from select table in DB but not Register.cshtml
            if (registryDate == "")
            {
                registryDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            }
            UniqueClientID = uniqueClientID;
            Username = username;
            Password = password;
            RegistryDate = registryDate;
            RegistryType = registryType;
        }
    }

    public class Student
    {
        public string UniqueClientID { get; set; }
        public string Name { get; set; }
        public char Gender { get; set; }
        public int Age { get; set; }
        public string Email { get; set; }
        public string Wechat { get; set; }
        public string QQ { get; set; }
        public string Phone { get; set; }
        public string University { get; set; }
        public string College { get; set; }
        public string Major { get; set; }
        public char Position { get; set; }
        public string Grade { get; set; }
        public string CardNo { get; set; }
        public string CardPass { get; set; }


        public Student()
        {

        }

        public Student(string uniqueClientID, string name, char gender, int age, string email, string wechat, string qQ, string phone, string university, string college, string major, char position, string grade, string cardNo, string cardPass)
        {
            UniqueClientID = uniqueClientID;
            Name = name;
            Gender = gender;
            Age = age;
            Email = email;
            Wechat = wechat;
            QQ = qQ;
            Phone = phone;
            University = university;
            College = college;
            Major = major;
            Position = position;
            Grade = grade;
            CardNo = cardNo;
            CardPass = cardPass;
        }

    }

    public class Teacher
    {
        public string UniqueClientID { get; set; }
        public string Name { get; set; }
        public char Gender { get; set; }
        public int Age { get; set; }
        public string Email { get; set; }
        public string Wechat { get; set; }
        public string QQ { get; set; }
        public string Phone { get; set; }
        public string University { get; set; }
        public string College { get; set; }
        public string Major { get; set; }
        public char Position { get; set; }
        public string Courses { get; set; }
        public string WorkNo { get; set; }
        public string WorkPass { get; set; }

        public Teacher()
        {

        }

        public Teacher(string uniqueClientID, string name, char gender, int age, string email, string wechat, string qQ, string phone, string university, string college, string major, char position, string courses, string workNo, string workPass)
        {
            UniqueClientID = uniqueClientID;
            Name = name;
            Gender = gender;
            Age = age;
            Email = email;
            Wechat = wechat;
            QQ = qQ;
            Phone = phone;
            University = university;
            College = college;
            Major = major;
            Position = position;
            Courses = courses;
            WorkNo = workNo;
            WorkPass = workPass;
        }

    }

    public class Course
    {
        public string CourseType { get; set; }
        public string CourseID { get; set; }
        public string CourseName { get; set; }
        public string CourseTeacher { get; set; }
        public string PublishDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string Venue { get; set; }
        public string Period { get; set; }
        public string ExamID { get; set; }
        public int Chosen { get; set; }
        public int Collected { get; set; }
        public string CourseInfo { get; set; }
        public string DetailInfo { get; set; }
        public string SubTag { get; set; }

        public Course(string courseID, string courseName, string courseTeacher, string publishDate, string startDate, string endDate, string venue, string period, string examID, int chosen, int collected, string courseInfo, string detailInfo, string subTag)
        {
            CourseID = courseID;
            CourseName = courseName;
            CourseTeacher = courseTeacher;
            PublishDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            StartDate = Convert.ToDateTime(startDate).ToString("yyyy-MM-dd HH:mm:ss");
            EndDate = Convert.ToDateTime(endDate).ToString("yyyy-MM-dd HH:mm:ss");
            Venue = venue;
            Period = period;
            ExamID = examID;
            Chosen = chosen;
            Collected = collected;
            CourseInfo = courseInfo;
            DetailInfo = detailInfo;
            SubTag = subTag;
        }
        public Course()
        {

        }
    }

    public class Exam
    {
        public string ExamID { get; set; }
        public string CourseID { get; set; }
        public string ExamDate { get; set; }
        public string ExamDuration { get; set; }
        public string ExamVenue { get; set; }
        public string ExamType { get; set; }

        public Exam(string examID, string courseID, string examDate, string examDuration, string examVenue, string examType)
        {
            ExamID = examID;
            CourseID = courseID;
            ExamDate = examDate;
            ExamDuration = examDuration;
            ExamVenue = examVenue;
            ExamType = examType;
        }

        public Exam()
        {
        }
    }

    public class Building
    {
        public string BuildCode { get; set; }
        public string BuildName { get; set; }
    }

    public class Room
    {
        public string RoomID { get; set; }
        public string RoomName { get; set; }
        public string RoomTag { get; set; }
        public string RoomBuilding { get; set; }
        public int RoomCapacity { get; set; }
    }






}