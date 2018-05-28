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
            string cmdTxt = "select uniqueClientID from login_examine where username='" + user.Username + "' and password='" + user.Password + "' and registryType='" + user.RegistryType.ToString() + "'";
            if (ifCheckboth == true)
            {
                cmdTxt = "select uniqueClientID from login_examine where username='" + user.Username + "' and password='" + user.Password + "'";
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
            user.RegistryType = user.UniqueClientID[1];
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
            }
            else
            {
                cmdTxt = "select uniqueClientID from login_examine where uniqueClientID like 'UT%' order by uniqueClientID desc limit 1";
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

            if (user.RegistryType == 'S')
            {
                Student student = (Student)X;
                student.UniqueClientID = user.UniqueClientID;
                //PLACEHOLDER
                cmdTxt1 = "insert into student_information values('" + student.UniqueClientID + "','" + student.Name + "','" + student.Gender + "','" + student.Age + "','" + student.Email + "','" + student.Wechat + "','" + student.QQ + "','" + student.Phone + "','" + student.University + "','" + student.College + "','" + student.Major + "','" + student.Position + "','" + student.Grade + "','" + student.CardNo + "','" + student.CardPass + "', 'A0001')";
            }
            else
            {
                Teacher teacher = (Teacher)X;
                teacher.UniqueClientID = user.UniqueClientID;
                //PLACEHOLDER
                cmdTxt1 = "insert into teacher_information values('" + teacher.UniqueClientID + "','" + teacher.Name + "','" + teacher.Gender + "','" + teacher.Age + "','" + teacher.Email + "','" + teacher.Wechat + "','" + teacher.QQ + "','" + teacher.Phone + "','" + teacher.University + "','" + teacher.College + "','" + teacher.Major + "','" + teacher.Courses + "','" + teacher.WorkNo + "','" + teacher.WorkPass + "', 'A0001')";
            }

            //insert SQL statement
            //very important format below
            //PLACEHOLDER
            cmdTxt = "insert into login_examine values('" + user.UniqueClientID + "','" + user.Username + "','" + user.Password + "','" + user.RegistryDate + "','" + user.RegistryType + "', 'Y')";

            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);
            //执行插入login_examine表
            cmd.ExecuteNonQuery();

            cmd = new MySqlCommand(cmdTxt1, connect);
            //执行插入X_information表
            cmd.ExecuteNonQuery();
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
            cmdTxt = "insert into course_information(courseID,courseName,courseTeacher,capacity,publishDate,startDate,endDate,venue,period,examID,courseInfo,subTag,faculty,ava) values('" + course.CourseID + "','" + course.CourseName + "','" + course.CourseTeacher + "','" + course.Capacity + "','" + course.PublishDate + "','" + course.StartDate + "','" + course.EndDate + "','" + course.Venue + "','" + course.Period + "','" + course.ExamID + "','" + course.CourseInfo + "','" + course.SubTag + "','" + course.Faculty + "','N')";
            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);


            cmd.ExecuteNonQuery();


            // 此处是向考试表中插入数据SQL语句
            cmdTxt = "update exam_information set courseID='" + course.CourseID + "',examDate='" + exam.ExamDate + "',examType='" + exam.ExamType + "',examDuration='" + exam.ExamDuration + "',examVenue='" + exam.ExamVenue + "',ava='N' where examID='" + course.ExamID + "'";
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

        //获取所有开放课程
        internal static DataSet GetCourseTable(string studentID = "")
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select courseID, courseName, startDate, endDate, venue, period, capacity, faculty, courseTeacher from course_information where ava='Y'";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            MySqlCommand cmd = null;
            adapter.Fill(set, "courses");

            string insert_cmd_text = "";                                                                                       //查询语句
            string headcount_of_each_course = "update course_information set chosen='";   //计算出每门课的人头数并插入数据库
            string where_clause = "' where courseID='";                                                            //where语句
            string end_of_sql = "'; ";                                                                                            //结束符

            //【未完成】计算量太大：每次访问全部课程页面均要执行这个函数，所以下面的代码会很臃肿。
            //下面这个循环计算出每门课的选课人数
            for (int i = 0; i < set.Tables["courses"].Rows.Count; i++)
            {
                cmdTxt = "select count(*) from course_records where cuid='" + set.Tables["courses"].Rows[i][0].ToString() + "' and ifdeleted='N'";
                adapter = new MySqlDataAdapter(cmdTxt, connect);
                adapter.Fill(set, set.Tables["courses"].Rows[i][0].ToString());
                if (set.Tables[set.Tables["courses"].Rows[i][0].ToString()].Rows[0][0].ToString() != "0")
                {
                    insert_cmd_text += headcount_of_each_course + set.Tables[set.Tables["courses"].Rows[i][0].ToString()].Rows[0][0].ToString() + where_clause + set.Tables["courses"].Rows[i][0].ToString() + end_of_sql;
                }
            }
            //Do the Insertion
            cmd = new MySqlCommand(insert_cmd_text, connect);
            cmd.ExecuteNonQuery();

            if (studentID != "")
            {
                cmdTxt = "select cuid,mtype from course_records where suid='" + studentID + "' and ifdeleted='N'";
                adapter = new MySqlDataAdapter(cmdTxt, connect);
                adapter.Fill(set, "selectedCourses");
            }
            else
            {
                set.Tables["courses"].Columns.Add("ifselected", Type.GetType("System.String"));
                set.Tables["courses"].Columns.Add("chosen", Type.GetType("System.String"));

                //----Totally copied from below "Add a row named ifselected"---- BEGIN//
                for (int i = 0; i < set.Tables["courses"].Rows.Count; i++)
                {
                    //该语句将每门课的选课人数放入courses表中
                    set.Tables["courses"].Rows[i][10] = set.Tables[set.Tables["courses"].Rows[i][0].ToString()].Rows[0][0];
                }
                //----Totally copied from below "Add a row named ifselected"---- END//
                return set;
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
                        set.Tables["courses"].Rows[i][9] = set.Tables["selectedCourses"].Rows[j][1];
                        break;
                    }
                    else
                    {
                        set.Tables["courses"].Rows[i][9] = ManipCourseType.N.ToString();
                    }
                }
                //该语句将每门课的选课人数放入courses表中
                set.Tables["courses"].Rows[i][10] = set.Tables[set.Tables["courses"].Rows[i][0].ToString()].Rows[0][0];
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

        internal static DataTable GetFacultyList()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select uniqueCode,name from faculty_information";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "Faculty");
            connect.Close();

            return set.Tables["Faculty"];
        }

        internal static string GetUser(string uid)
        {
            if (uid == null || uid == "")
            {
                return null;
            }
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
            //type:  A/B/C ----- Chosen/Collected/Both
            who = who.Substring(0, 10);
            which = which.Substring(0, 10);

            MySqlConnection connect = new MySqlConnection(connectionString);

            //Start of connection
            connect.Open();
            string cmdTxt = "select mtype,ifdeleted from course_records where suid = '" + who + "' and cuid='" + which + "'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            DataSet set = new DataSet();
            adapter.Fill(set, "mtype");

            if (set.Tables["mtype"].Rows.Count == 0)
            {
                cmdTxt = "insert into course_records values('" + who + "','" + which + "','" + type.ToString() + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','N')";
            }
            else
            {
                if (set.Tables["mtype"].Rows[0][1].ToString() == "Y")
                {
                    cmdTxt = "update course_records set mtype='" + type.ToString() + "', ifdeleted='N' where suid='" + who + "' and cuid='" + which + "'";
                }
                else
                {
                    //这里存在一个问题：当用户选择/收藏一门课程后，没有刷新页面而是使用缓存再次进入选择该课程页面并点击同一个按钮时，就会出现type='C'的失误。
                    //这个问题似乎是异步刷新带来的。客户端没有及时更新。
                    cmdTxt = "update course_records set mtype='C' where suid='" + who + "' and cuid='" + which + "' and ifdeleted='N'";
                }

            }

            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);
            var result = cmd.ExecuteNonQuery();
            //End of connection
            connect.Close();
        }


        internal static void DeselectCourse(string who, string which, char type = 'a')
        {
            //who:   suid
            //which: cuid
            //type:  a/b -----  Unchosen/Uncollected
            who = who.Substring(0, 10);
            which = which.Substring(0, 10);

            switch (type)
            {
                case 'a': type = 'B'; break;
                case 'b': type = 'A'; break;
                default: return;
            }

            MySqlConnection connect = new MySqlConnection(connectionString);

            //Start of connection
            connect.Open();
            string cmdTxt = "select mtype from course_records where suid = '" + who + "' and cuid='" + which + "' and ifdeleted='N'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            DataSet set = new DataSet();
            adapter.Fill(set, "mtype");

            if (set.Tables["mtype"].Rows.Count == 0)
            {
                return;
            }
            else
            {
                if (set.Tables["mtype"].Rows[0][0].ToString() == "C")
                {
                    cmdTxt = "update course_records set mtype='" + type.ToString() + "' where suid='" + who + "' and cuid='" + which + "' and ifdeleted='N'";
                }
                else
                {
                    cmdTxt = "update course_records set ifdeleted='Y' where suid='" + who + "' and cuid='" + which + "'";
                }
            }

            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);
            var result = cmd.ExecuteNonQuery();
            //End of connection
            connect.Close();
        }


        internal static DataSet GetCourseOfTeacher(string courseTeacherID)  //courseTeacherID = uniqueClientID of Teacher
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            //Get all the courses of a specified teacher
            string cmdTxt = "select * from course_information where courseTeacher='" + courseTeacherID + "'";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "CoursesOfTeacher");

            #region Compute the exact course table of specified teacher
            //Has been moved to a method called ComputeCourseTable(ref DataSet set)
            set = ComputeCourseTable(ref set, "CoursesOfTeacher");
            #endregion


            //Get the count of heads attending each of the course of the teacher 
            for (int index = 0; index < set.Tables["CoursesOfTeacher"].Rows.Count; index++)
            {
                cmdTxt = "select count(*) from course_records where cuid='" + set.Tables["CoursesOfTeacher"].Rows[index][0] + "' and ifdeleted='N'";
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

        //Compute the exact course table of specified teacher
        private static DataSet ComputeCourseTable(ref DataSet set, string tablename)
        {
            DataTable courseTable = new DataTable("courseTable");
            string[] week =
                //{ "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" };
                { "A", "B", "C", "D", "E", "F", "G" };
            string[] period = 
                //{ "一二节", "三四节", "三四五节", "六七节", "八九节", "十十一十二节" };
                { "A", "B", "C", "D", "E", "F" };
            for (int i = 0; i < period.Length; i++)
            {
                for (int j = 0; j < week.Length; j++)
                {
                    courseTable.Columns.Add(week[j] + period[i]);
                }
            }
            DataRow timerow = null, idrow = null;
            timerow = courseTable.NewRow();
            idrow = courseTable.NewRow();
            for (int i = 0; i < set.Tables[tablename].Rows.Count; i++)
            {
                DataRow row = set.Tables[tablename].Rows[i];
                switch (row[7].ToString())
                {
                    case "AA": timerow["AA"] = row[0].ToString(); idrow["AA"] = row[1].ToString(); break;
                    case "BA": timerow["BA"] = row[0].ToString(); idrow["BA"] = row[1].ToString(); break;
                    case "CA": timerow["CA"] = row[0].ToString(); idrow["CA"] = row[1].ToString(); break;
                    case "DA": timerow["DA"] = row[0].ToString(); idrow["DA"] = row[1].ToString(); break;
                    case "EA": timerow["EA"] = row[0].ToString(); idrow["EA"] = row[1].ToString(); break;
                    case "FA": timerow["FA"] = row[0].ToString(); idrow["FA"] = row[1].ToString(); break;
                    case "GA": timerow["GA"] = row[0].ToString(); idrow["GA"] = row[1].ToString(); break;
                    case "AB": timerow["AB"] = row[0].ToString(); idrow["AB"] = row[1].ToString(); break;
                    case "BB": timerow["BB"] = row[0].ToString(); idrow["BB"] = row[1].ToString(); break;
                    case "CB": timerow["CB"] = row[0].ToString(); idrow["CB"] = row[1].ToString(); break;
                    case "DB": timerow["DB"] = row[0].ToString(); idrow["DB"] = row[1].ToString(); break;
                    case "EB": timerow["EB"] = row[0].ToString(); idrow["EB"] = row[1].ToString(); break;
                    case "FB": timerow["FB"] = row[0].ToString(); idrow["FB"] = row[1].ToString(); break;
                    case "GB": timerow["GB"] = row[0].ToString(); idrow["GB"] = row[1].ToString(); break;
                    case "AC": timerow["AC"] = row[0].ToString(); idrow["AC"] = row[1].ToString(); break;
                    case "BC": timerow["BC"] = row[0].ToString(); idrow["BC"] = row[1].ToString(); break;
                    case "CC": timerow["CC"] = row[0].ToString(); idrow["CC"] = row[1].ToString(); break;
                    case "DC": timerow["DC"] = row[0].ToString(); idrow["DC"] = row[1].ToString(); break;
                    case "EC": timerow["EC"] = row[0].ToString(); idrow["EC"] = row[1].ToString(); break;
                    case "FC": timerow["FC"] = row[0].ToString(); idrow["FC"] = row[1].ToString(); break;
                    case "GC": timerow["GC"] = row[0].ToString(); idrow["GC"] = row[1].ToString(); break;
                    case "AD": timerow["AD"] = row[0].ToString(); idrow["AD"] = row[1].ToString(); break;
                    case "BD": timerow["BD"] = row[0].ToString(); idrow["BD"] = row[1].ToString(); break;
                    case "CD": timerow["CD"] = row[0].ToString(); idrow["CD"] = row[1].ToString(); break;
                    case "DD": timerow["DD"] = row[0].ToString(); idrow["DD"] = row[1].ToString(); break;
                    case "ED": timerow["ED"] = row[0].ToString(); idrow["ED"] = row[1].ToString(); break;
                    case "FD": timerow["FD"] = row[0].ToString(); idrow["FD"] = row[1].ToString(); break;
                    case "GD": timerow["GD"] = row[0].ToString(); idrow["GD"] = row[1].ToString(); break;
                    case "AE": timerow["AE"] = row[0].ToString(); idrow["AE"] = row[1].ToString(); break;
                    case "BE": timerow["BE"] = row[0].ToString(); idrow["BE"] = row[1].ToString(); break;
                    case "CE": timerow["CE"] = row[0].ToString(); idrow["CE"] = row[1].ToString(); break;
                    case "DE": timerow["DE"] = row[0].ToString(); idrow["DE"] = row[1].ToString(); break;
                    case "EE": timerow["EE"] = row[0].ToString(); idrow["EE"] = row[1].ToString(); break;
                    case "FE": timerow["FE"] = row[0].ToString(); idrow["FE"] = row[1].ToString(); break;
                    case "GE": timerow["GE"] = row[0].ToString(); idrow["GE"] = row[1].ToString(); break;
                    case "AF": timerow["AF"] = row[0].ToString(); idrow["AF"] = row[1].ToString(); break;
                    case "BF": timerow["BF"] = row[0].ToString(); idrow["BF"] = row[1].ToString(); break;
                    case "CF": timerow["CF"] = row[0].ToString(); idrow["CF"] = row[1].ToString(); break;
                    case "DF": timerow["DF"] = row[0].ToString(); idrow["DF"] = row[1].ToString(); break;
                    case "EF": timerow["EF"] = row[0].ToString(); idrow["EF"] = row[1].ToString(); break;
                    case "FF": timerow["FF"] = row[0].ToString(); idrow["FF"] = row[1].ToString(); break;
                    case "GF": timerow["GF"] = row[0].ToString(); idrow["GF"] = row[1].ToString(); break;
                }
            }
            courseTable.Rows.Add(idrow);
            courseTable.Rows.Add(timerow);
            set.Tables.Add(courseTable);
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
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "courseSelected");

            if (set.Tables["courseSelected"].Rows.Count == 0)
            {
                return null;
            }

            #region In order to Select All The Courses's info of Specific Student
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

            //Select the entire information correspond to the specific course
            cmdTxt = "select * from course_information where courseID in " + coursesAsTuple;
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "selectedCourseInfo");
            connect.Close();
            set = ComputeCourseTable(ref set, "selectedCourseInfo");

            return set;
        }

        internal static string GetSpecificUser(string id)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string table_to_select = "student_information";
            if (id[1] == 'T')
            {
                table_to_select = "teacher_information";
            }

            string cmdTxt = "select * from " + table_to_select + " where uniqueClientID=" + "'" + id + "'";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "SpecificUser");
            connect.Close();

            string result = "", sep = "&";
            for (int i = 0; i < set.Tables["SpecificUser"].Columns.Count; i++)
            {
                string columnName = set.Tables["SpecificUser"].Columns[i].ColumnName;
                result = result + columnName + "=" + set.Tables["SpecificUser"].Rows[0][i].ToString() + sep;
            }
            result = result.Substring(0, result.Length - 1);
            return result;
        }

        internal static int ModifyDBwithSQL(string cmdTxt)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            MySqlCommand cmd = new MySqlCommand(cmdTxt, connect);
            //Start of connection
            connect.Open();
            int affectedRows = cmd.ExecuteNonQuery();
            connect.Close();

            return affectedRows;
        }

        internal static string LoadDenpendencies()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select uniqueCode,name from faculty_information";  //Get Faculty
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "Faculty");

            cmdTxt = "select * from v_uidname where uid like 'UT%'";  //Get Teacher's Name
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "TeacherName");

            cmdTxt = "select roomID, roomName from room_information";  //Get room name
            adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "RoomName");
            //Connection Close
            connect.Close();

            string result = "", sep = "&";
            for (int i = 0; i < set.Tables["Faculty"].Rows.Count; i++)                       //Faculty
            {
                result = result + set.Tables["Faculty"].Rows[i][0].ToString() + "=" + set.Tables["Faculty"].Rows[i][1].ToString() + sep;
            }
            result = result + "*&";  //Become a string containing multiple lists of info
            for (int i = 0; i < set.Tables["TeacherName"].Rows.Count; i++)            //Teacher Name
            {
                result = result + set.Tables["TeacherName"].Rows[i][0].ToString() + "=" + set.Tables["TeacherName"].Rows[i][1].ToString() + sep;
            }
            result = result + "*&";  //Become a string containing multiple lists of info
            for (int i = 0; i < set.Tables["RoomName"].Rows.Count; i++)            //Room Name
            {
                result = result + set.Tables["RoomName"].Rows[i][0].ToString() + "=" + set.Tables["RoomName"].Rows[i][1].ToString() + sep;
            }
            result = result.Substring(0, result.Length - 1);
            return result;
        }

        internal static DataTable GetAllCourses()
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select * from course_information";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "AllCourses");
            connect.Close();
            return set.Tables["AllCourses"];
        }

        internal static string IfConflicted(string venue, string period)    //venue: roomID  period: dayperiod
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select * from roomuse_information where roomID='" + venue + "' and dayperiod='" + period + "' and ava='Y'";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "ifconflicted");
            connect.Close();

            if (set.Tables["ifconflicted"].Rows.Count == 0)
            {
                return "false";
            }
            else
            {
                string result = "";
                for (int i = 0; i < set.Tables["ifconflicted"].Columns.Count; i++)
                {
                    result += set.Tables["ifconflicted"].Columns[i].ColumnName + "=" + set.Tables["ifconflicted"].Rows[0][i].ToString() + "&";
                }
                result = result.Substring(0, result.Length - 1);
                return result;
            }
        }

        internal static bool IfConflictedStudent(string period, string studentID)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            string cmdTxt = "select '" + period + "' in (select period from course_information where courseID in (select cuid from course_records where suid='" + studentID + "'))";
            DataSet set = new DataSet();

            //Start of connection
            connect.Open();
            MySqlDataAdapter adapter = new MySqlDataAdapter(cmdTxt, connect);
            adapter.Fill(set, "ifconflictedstudent");
            connect.Close();
            if (set.Tables["ifconflictedstudent"].Rows[0][0].ToString() == "0")
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }


}