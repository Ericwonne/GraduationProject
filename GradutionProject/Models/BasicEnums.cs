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
}