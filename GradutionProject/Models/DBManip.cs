using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace GradutionProject.Models
{
    public class DBManip
    {
        private static string connectionString = "Server=localhost;Database=gpdb;User id = root; password=;";

        //Check if user already exist in the DB table gpdb.login_examine
        internal static bool CheckUserExistence(ref User user, bool ifCheckboth = false)
        {
            string cmdTxt = "select uniqueClientID,registryType from login_examine where username='" + user.Username + "' and password='" + user.Password + "' and registryType='" + user.RegistryType.ToString() + "'";
            if (ifCheckboth == true)
            {
                cmdTxt = "select uniqueClientID,registryType from login_examine where username='" + user.Username + "' and password='" + user.Password + "'";
            }
            MySqlConnection connect = new MySqlConnection(connectionString);
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "ID");
            connect.Close();

            //Check
            if (set.Tables["ID"].Rows.Count == 0)
            {
                //User doesn't exist
                return false;
            }
            //User exists
            user.UniqueClientID = set.Tables["ID"].Rows[0][0].ToString();
            user.RegistryType = Convert.ToChar(set.Tables["ID"].Rows[0][1].ToString());
            return true;
        }

        //Add new user into DB table gpdb.login_examine
        internal static void AddUser(User user, object X)
        {

            MySqlConnection connect = new MySqlConnection(connectionString);

            string cmdTxt, cmdTxt1;     //cmdTxt1 is for the student/teacher information insert SQL
            //Judge if student user
            if (user.RegistryType == 'S')
            {
                cmdTxt = "select uniqueClientID from login_examine where uniqueClientID like 'US%' order by uniqueClientID desc limit 1";
                Student student = (Student)X;
                cmdTxt1 = "insert into student_information values('" + student.UniqueClientID + "','" + student.Name + "','" + student.Gender + "','" + student.Age + "','" + student.Email + "','" + student.Wechat + "','" + student.QQ + "','" + student.Phone + "','" + student.University + "','" + student.College + "','" + student.Major + "','" + student.Position + "','" + student.Grade + "','" + student.CardNo + "','" + student.CardPass + "')";
            }
            else
            {
                cmdTxt = "select uniqueClientID from login_examine where uniqueClientID like 'UT%' order by uniqueClientID desc limit 1";
                Teacher teacher = (Teacher)X;
                cmdTxt1 = "insert into teacher_information values('" + teacher.UniqueClientID + "','" + teacher.Name + "','" + teacher.Gender + "','" + teacher.Age + "','" + teacher.Email + "','" + teacher.Wechat + "','" + teacher.QQ + "','" + teacher.Phone + "','" + teacher.University + "','" + teacher.College + "','" + teacher.Major + "','" + teacher.Courses + "','" + teacher.WorkNo + "','" + teacher.WorkPass + "')";
            }
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "uniqueID");
            DataRow row = set.Tables["uniqueID"].Rows[0];
            var uniqueID = row[0].ToString();
            uniqueID = GetUniqueID(uniqueID, uniqueID[1]);
            user.UniqueClientID = uniqueID;

            //insert SQL statement
            //very important format below
            cmdTxt = "insert into login_examine values('" + user.UniqueClientID + "','" + user.Username + "','" + user.Password + "','" + user.RegistryDate + "','" + user.RegistryType + "')";

            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch
            {

            }

            //End of connection
            connect.Close();

        }

        //
        internal static void AddCourse(Course course, Exam exam)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);

            string cmdTxt, cmdTxt1;
            //CourseType can't be null or empty
            // 此处应该使用联合查询，得到两个表的数据【未完成】
            cmdTxt = "select courseID from course_information where courseID like '" + course.CourseType + "%' order by courseID desc limit 1";
            cmdTxt1 = "select examID from exam_information where examID like 'E" + course.CourseType[1].ToString() + "%' order by examID desc limit 1";


            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "courseID");
            adapter = new MySqlDataAdapter(cmdTxt1, connect);
            adapter.Fill(set, "examID");

            //Check existence. If not exist, create itself
            int courseID_num;
            if (set.Tables["courseID"].Rows.Count == 0)
            {
                courseID_num = 1;
            }
            else
            {
                //Get the number part of courseID
                string courseID = set.Tables["courseID"].Rows[0][0].ToString().Substring(4, 6);
                courseID_num = Convert.ToInt32(courseID);
                courseID_num++;
            }
            int examID_num;
            if (set.Tables["examID"].Rows.Count == 0)
            {
                examID_num = 1;
            }
            else
            {
                string examID = set.Tables["examID"].Rows[0][0].ToString().Substring(4, 6);
                examID_num = Convert.ToInt32(examID);
                examID_num++;
            }

            //New CourseID; XX means subTag
            course.CourseID = course.CourseType + "XX" + courseID_num.ToString().PadLeft(6, '0');
            course.ExamID = "E" + course.CourseType[1].ToString() + "XX" + examID_num.ToString().PadLeft(6, '0');

            // 此处是向课程表中插入数据SQL语句
            //【问题yi解决】：数据库中的课程表和考试表中的编号互为外键制约，现在导致插入课程表中外键数据时有一定的问题
            //【解决办法】：在数据库中实现触发器，当更新课程表中的CourseID的时候，外键于此的考试表中的CourseID同时更新。
            //【问题】重复插入的时候要做容错判断，否则会出错。
            cmdTxt = "insert into course_information(courseID,courseName,courseTeacher,publishDate,startDate,endDate,venue,period,examID,courseInfo,subTag) values('" + course.CourseID + "','" + course.CourseName + "','" + course.CourseTeacher + "','" + course.PublishDate + "','" + course.StartDate + "','" + course.EndDate + "','" + course.Venue + "','" + course.Period + "','" + course.ExamID + "','" + course.CourseInfo + "','" + course.SubTag + "')";
            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);


            cmd.ExecuteNonQuery();


            // 此处是向考试表中插入数据SQL语句
            cmdTxt = "update exam_information set courseID='" + course.CourseID + "',examDate='" + exam.ExamDate + "',examType='" + exam.ExamType + "',examDuration='" + exam.ExamDuration + "',examVenue='" + exam.ExamVenue + "' where examID='" + course.ExamID + "'";
            cmd.CommandText = cmdTxt;
            cmd.ExecuteNonQuery();


            //End of connection
            connect.Close();
        }


        //【此函数已废弃使用】
        internal static void AddExam(Exam exam)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);

            string cmdTxt;

            cmdTxt = "select examID from exam_information order by examID desc limit 1";

            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "examID");
            DataRow row = set.Tables["examID"].Rows[0];
            var examID = row[0].ToString().Substring(4, 6);
            int examID_num = Convert.ToInt32(examID);
            examID_num++;
            exam.ExamID = "EAXX" + examID_num.ToString().PadLeft(6, '0');

            //insert SQL statement
            //very important format below
            cmdTxt = "insert into exam_information() values('" + exam.ExamID + "','" + exam.ExamDate + "','" + exam.ExamType + "','" + exam.ExamDuration + "','" + exam.ExamVenue + "')";

            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch
            {

            }

            //End of connection
            connect.Close();
        }


        // 此处下面两个【Method】还有许多需要优化的地方：数据库连接操作可以封装起来
        internal static DataTable GetUserTable()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select v_uidname.uid,v_uidname.uname,login_examine.username,login_examine.registryDate,login_examine.registryType from v_uidname inner join login_examine on v_uidname.uid=login_examine.uniqueclientid order by uniqueclientid";

            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "login_examine");
            connect.Close();
            DataTable table = set.Tables["login_examine"];

            return table;
        }

        internal static DataTable GetTeacherTable()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select * from teacher_information";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "teacher_information");
            connect.Close();

            for (int index = 0; index < set.Tables["teacher_information"].Rows.Count; index++)
            {
                switch (set.Tables["teacher_information"].Rows[index][2].ToString())
                {
                    case "M": set.Tables["teacher_information"].Rows[index][2] = "男"; break;
                    case "F": set.Tables["teacher_information"].Rows[index][2] = "女"; break;
                    case "U": set.Tables["teacher_information"].Rows[index][2] = "未知"; break;
                }
            }

            return set.Tables["teacher_information"];
        }

        internal static DataTable GetStudentTable()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select * from student_information";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "student_information");
            connect.Close();

            return set.Tables["student_information"];
        }

        internal static DataSet GetCourseTable(string studentID = "")
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select courseID, courseName, startDate, endDate, venue, period, capacity from course_information";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "courses");

            if (studentID != "")
            {
                cmdTxt = "select cuid,mtype from course_records where suid='" + studentID + "' and ifdeleted='N'";
                adapter = new MySqlDataAdapter(cmdTxt, connect);
                adapter.Fill(set, "selectedCourses");
            }

            for (int i = 0; i < set.Tables["courses"].Rows.Count; i++)
            {
                cmdTxt = "select count(*) from course_records where cuid='" + set.Tables["courses"].Rows[i][0].ToString() + "' and ifdeleted='N'";
                adapter = new MySqlDataAdapter(cmdTxt, connect);
                adapter.Fill(set, set.Tables["courses"].Rows[i][0].ToString());
            }
            connect.Close();

            //Add a row named ifselected
            set.Tables["courses"].Columns.Add("ifselected", Type.GetType("System.String"));
            set.Tables["courses"].Columns.Add("chosen", Type.GetType("System.String"));
            for (int i = 0; i < set.Tables["courses"].Rows.Count; i++)
            {
                for (int j = 0; j < set.Tables["selectedCourses"].Rows.Count; j++)
                {
                    if (set.Tables["courses"].Rows[i][0].ToString() == set.Tables["selectedCourses"].Rows[j][0].ToString())
                    {
                        set.Tables["courses"].Rows[i][7] = set.Tables["selectedCourses"].Rows[j][1];
                        break;
                    }
                    else
                    {
                        set.Tables["courses"].Rows[i][7] = ManipCourseType.N.ToString();
                    }
                }
                set.Tables["courses"].Rows[i][8] = set.Tables[set.Tables["courses"].Rows[i][0].ToString()].Rows[0][0];
            }
            return set;
        }

        internal static DataSet GetCourseInfo(string courseID)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select * from course_information where courseID='" + courseID + "'";  //Select exact info of a course
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "courseInfo");

            cmdTxt = "select * from teacher_information where uniqueClientID='" + set.Tables["courseInfo"].Rows[0][2].ToString() + "'";  //Select teacher info of that course
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "teacherInfo");

            connect.Close();
            return set;
        }


        //Calculate the correct uniqueID according to Database recoreds
        //Params: ID is string confined in Length(10); type is char equal 'S' or 'T' or ''...
        private static string GetUniqueID(string ID, char type)
        {
            string[] splits = ID.Split(type);
            var number = Convert.ToInt32(splits[splits.Length - 1]);
            number++;
            splits[splits.Length - 1] = "U" + type.ToString() + number.ToString().PadLeft(8, '0');
            return splits[1];
        }

        internal static DataTable GetBuildingList()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select * from build_information";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "BuildingList");
            connect.Close();

            return set.Tables["BuildingList"];
        }

        internal static DataTable GetRoomList()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select roomID,roomName,roomCapacity from room_information";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "RoomList");
            connect.Close();

            return set.Tables["RoomList"];
        }

        internal static DataTable GetSubjectList()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select * from subject_category where code like 'C%'";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "SubjectList");
            connect.Close();

            return set.Tables["SubjectList"];
        }

        internal static string GetUser(string uid)
        {
            string cmdTxt;
            if (uid[1] == 'T')
            {
                cmdTxt = "select name from teacher_information where uniqueClientID='" + uid + "'";
            }
            else
            {
                cmdTxt = "select name from student_information where uniqueClientID='" + uid + "'";
            }
            MySqlConnection connect = new MySqlConnection(connectionString);

            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "uname");
            connect.Close();
            string uname = set.Tables["uname"].Rows[0][0].ToString();
            return uname;
        }

        internal static void SelectCourse(string who, string which, char type = 'A')
        {
            //who:   suid
            //which: cuid
            //type:  A/B/C
            who = who.Substring(0, 10);
            which = which.Substring(0, 10);

            MySqlConnection connect = new MySqlConnection(connectionString);

            //Start of connection
            connect.Open();
            string cmdTxt = "select mtype from course_records where suid = '" + who + "' and cuid='" + which + "' and ifdeleted='N'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            DataSet set = new DataSet();
            adapter.Fill(set, "mtype");

            if (set.Tables["mtype"].Rows.Count == 0)
            {
                cmdTxt = "insert into course_records values('" + who + "','" + which + "','" + type.ToString() + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','N')";
            }
            else
            {
                cmdTxt = "update course_records set mtype='C' where suid='" + who + "' and cuid='" + which + "' and ifdeleted='N'";
            }

            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);
            var result = cmd.ExecuteNonQuery();
            //End of connection
            connect.Close();
        }

        internal static DataSet GetCourseOfTeacher(string courseTeacherID)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            //Get all the courses of a specific teacher
            string cmdTxt = "select * from course_information where courseTeacher='" + courseTeacherID + "'";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "CoursesOfTeacher");

            //
            for (int index = 0; index < set.Tables["CoursesOfTeacher"].Rows.Count; index++)
            {
                cmdTxt = "select count(*) from course_records where cuid='" + set.Tables["CoursesOfTeacher"].Rows[index][0] + "'";

                adapter = new MySqlDataAdapter(cmdTxt, connect);
                adapter.Fill(set, "count" + set.Tables["CoursesOfTeacher"].Rows[index][0].ToString());
            }

            //Get the semester info
            cmdTxt = "select * from semester where start<'" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' and end>'" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "StartEndDate");

            //Get all the student entitled to this teacher's courses
            cmdTxt = "select * from student_information where uniqueClientID in (select suid from course_records where cuid in (select courseID from course_information where courseTeacher='" + courseTeacherID + "'))";
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "AllMyStudent");


            //End of connection
            connect.Close();

            DataRow startendDate = set.Tables["StartEndDate"].Rows[0];
            DataRow[] this_semester_course = set.Tables["CoursesOfTeacher"].Select("startDate >='" + startendDate[2].ToString() + "' and endDate<='" + startendDate[3].ToString() + "'");

            //Get the exactly the currently semester included courses 
            if (this_semester_course.Length != 0)
            {
                //必须先克隆表的结构才能使用
                DataTable new_table = set.Tables["CoursesOfTeacher"].Clone();
                new_table.TableName = "this_semester_course";
                set.Tables.Add(new_table);

                foreach (DataRow row in this_semester_course)
                    set.Tables["this_semester_course"].Rows.Add(row.ItemArray);
            }
            else
            {
                return null;
            }
            //returns the whole set of courses of that teacher
            return set;
        }

        internal static DataSet GetCourseOfStudent(string uniqueClientID)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            //Get the courses selected by student
            string cmdTxt = "select cuid,mtime from course_records where suid='" + uniqueClientID + "' and (mtype='A'or mtype='C') and ifdeleted='N'";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();

            #region Select All The Courses of Specific Student
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "courseSelected");
            string coursesAsTuple = "", coursesAsTupleBegin = "(", coursesAsTupleEnd = ")";
            for (int i = 0; i < set.Tables["courseSelected"].Rows.Count; i++)
            {
                coursesAsTuple += "'" + set.Tables["courseSelected"].Rows[i][0].ToString() + "'" + ",";
            }
            coursesAsTuple = coursesAsTuple.Substring(0, coursesAsTuple.Length - 1);
            coursesAsTuple = coursesAsTupleBegin + coursesAsTuple + coursesAsTupleEnd;
            #endregion

            //Get the courses collected by student
            cmdTxt = "select cuid,mtime from course_records where suid='" + uniqueClientID + "' and (mtype='B'or mtype='C') and ifdeleted='N'";
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "courseCollected");

            cmdTxt = "select * from course_information where courseID in " + coursesAsTuple;
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "selectedCourseInfo");

            connect.Close();

            return set;
        }

    }


}