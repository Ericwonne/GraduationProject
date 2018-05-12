using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GradutionProject.Models
{
    public enum ManipCourseType
    {
        A, //Select
        B, //Collect
        C, //Select and Collect
        N  //Not manipulated
    }
    public enum Position
    {
        B, M, D
        //bachelor, master, doctor
    }
    public enum Grade
    {
        FR, //freshman
        SO, //sophomore
        JU, //junior
        SE, //senior
    }
    public enum ExamType
    {
        开卷, 闭卷
    }
    public enum Gender
    {
        M, F, U           //Male, Female, Unknown
    }
    public enum Subject
    {
        CA, CB, CC, CD, CE, CF, CG, CH, CI, CJ, CK, CL, CM
        //Detail meaning see AddCourses.cshtml
        //"CA">     哲学
        //"CB">     经济学
        //"CC">     法学
        //"CD">     教育学
        //"CE">     文学
        //"CF">      历史学
        //"CG">     理学
        //"CH">     工学
        //"CI">      农学
        //"CJ">      医学
        //"CK">     军事学
        //"CL">      管理学
        //"CM">     艺术学
    }
    public enum Build
    {
        A1,         // 第一教学楼                    
        A2,         // 第二教学楼                    
        A3,         // 第三教学楼                    
        A4,         // 第四教学楼                    
        A5,         // 综合教学楼                          
        A6,         // 光电信息与计算机工程学院大楼               
        A7,         // 演讲厅                                   
        A8,         // 健身房                                    
        B1,         // 环境与建筑学院大楼                         
        B2,         // 能源与动力学院大楼                         
        B3,         // 机械学院大楼                              
        BH,         // 大礼堂                                    
        MH,         // 音乐堂                                    
        SH,         // 小礼堂                                    
        SW,         // 游泳池                   
    }

    public class PeriodGetter
    {
        public PeriodGetter()
        {
            Period.Add("AC", "星期一3,4,5节");
            Period.Add("EF", "星期一3,4,5节");
            Period.Add("ED", "星期一3,4,5节");
            Period.Add("DE", "星期一3,4,5节");
            Period.Add("GF", "星期一3,4,5节");
            Period.Add("DF", "星期一3,4,5节");
            Period.Add("AA", "星期一3,4,5节");
            Period.Add("DC", "星期一3,4,5节");
            Period.Add("EE", "星期一3,4,5节");
        }
        public Dictionary<string, string> Period = new Dictionary<string, string>();
    }

    public static class Miscellaneous
    {
        public static PeriodGetter P = new PeriodGetter();
    }
}
