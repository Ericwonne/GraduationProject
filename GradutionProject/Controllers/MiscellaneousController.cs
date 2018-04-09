using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Mvc;
using GradutionProject.Models;

namespace GradutionProject.Controllers
{
    public class MiscellaneousController : Controller
    {
        // GET: Miscellaneous
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddRoom()
        {
            DataTable table = DBManip.GetBuildingList();

            return View(table);
        }
        public object AddRooms()
        {
            return "添加成功";
        }
        public ActionResult AddBuilding()
        {
            DataTable table = DBManip.GetBuildingList();
            //table.Columns.Remove(table.Columns["rooms"]);
            return View(table);
        }
    }
}