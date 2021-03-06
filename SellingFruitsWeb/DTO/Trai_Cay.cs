﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SellingFruitsWeb.DTO
{
    public class Trai_Cay
    {
        public string Ma_Trai_Cay { get; set; }

        public string Ten_Trai_Cay { get; set; }

        public int So_Luong { get; set; }

        public int Don_Gia_Nhap { get; set; }

        public int Don_Gia_Xuat { get; set; }

        public string Don_Vi_Tinh { get; set; }

        public string Xuat_Xu { get; set; }

        public string Mo_Ta { get; set; }

        public string Loai_ID { get; set; }

        public string Ten_Loai_TC { get; set; }

        public Trai_Cay()
        {
        }

        public Trai_Cay(string ma_Trai_Cay, string ten_Trai_Cay, int so_Luong, int don_Gia_Nhap, int don_Gia_Xuat, string don_Vi_Tinh, string xuat_Xu, string mo_Ta, string loai_ID, string ten_Loai_TC)
        {
            Ma_Trai_Cay = ma_Trai_Cay;
            Ten_Trai_Cay = ten_Trai_Cay;
            So_Luong = so_Luong;
            Don_Gia_Nhap = don_Gia_Nhap;
            Don_Gia_Xuat = don_Gia_Xuat;
            Don_Vi_Tinh = don_Vi_Tinh;
            Xuat_Xu = xuat_Xu;
            Mo_Ta = mo_Ta;
            Loai_ID = loai_ID;
            Ten_Loai_TC = ten_Loai_TC;
        }
    }
}