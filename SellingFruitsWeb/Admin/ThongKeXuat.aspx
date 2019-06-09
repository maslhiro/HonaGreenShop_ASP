﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="ThongKeXuat.aspx.cs" Inherits="SellingFruitsWeb.Admin.ThongKeXuat" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="/static/gijgo-datepicker/css/gijgo.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="#">Thống kê xuất</a>
            </li>
            <li class="breadcrumb-item active">Overview</li>
        </ol>

        <!-- Button thống kê filter-->
        <div class="d-flex m-3 flex-row">
            <input id="dpkFrom" width="180" />
            <div>&#160</div>
            <div class="d-flex justify-content-center align-items-center m-2">
                <i class="fas fa-arrow-alt-circle-right fa-lg"></i>
            </div>
            <input id="dpkTo" width="180" />
            <div>&#160</div>
            <button type="button" id="btnThongKeTheoNgay" class="btn btn-danger">Lọc</button>
            <div>&#160</div>
            <button type="button" id="btnRefresh" class="btn btn-danger">Tải lại</button>

        </div>

        <div id="alert"></div>

        <!-- DataTables -->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fas fa-table"></i>
                <label id="tableHeader">Bảng thống kê </label>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Tên trái cây</th>
                                <th>Thời gian</th>
                                <th>Xuất xứ</th>
                                <th>#</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Tên trái cây</th>
                                <th>Thời gian</th>
                                <th>Xuất xứ</th>
                                <th>#</th>
                            </tr>
                        </tfoot>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex row m-4 justify-content-end">
                    <div  id="txtTotal">Tổng cộng : </div>
                </div>
            </div>

        </div>

    </div>

    <!-- Page level plugin JavaScript-->
    <script src="/static/vendor/datatables/jquery.dataTables.js"></script>
    <script src="/static/vendor/datatables/dataTables.bootstrap4.js"></script>
    <script src="/static/js/popper.min.js"></script>
    <script src="/static/gijgo-datepicker/js/gijgo.js" type="text/javascript"></script>

    <script type="text/javascript">
        var table;

        function loadTable() {
            table = $('#dataTable').DataTable({
                processing: true,
                paging: true,
                searching: true,
                ajax: {
                    url: '/Api/ThongKeXuat.ashx?DataType=1',
                    dataSrc: 'Data'
                },
                columns: [
                    { data: 'Ma_Don_Hang' },
                    { data: 'Ten_Trai_Cay' },
                    { data: 'Thoi_Gian' },
                    { data: 'Xuat_Xu' },
                    {
                        "data": null,
                        "defaultContent": `<div align="center"><button type="button" id="btnChiTiet" class="btn btn-secondary" >Xem chi tiết</button></div>`
                    },
                ]
            });
        }

        //Button XemChiTiet
        $('#dataTable tbody').on('click', '#btnChiTiet', function () {
                let data = table.row($(this).parents('tr')).data();
                window.open('/Admin/ChiTietDonHang.aspx?MaDonHang=' + data.Ma_Don_Hang, '_blank');
        });

        function btnThongKeTheoNgay_OnClick(e) {
            e.preventDefault();

            let thoiGianThongKe = {
                "From_Date": $("#dpkFrom").val() ? $("#dpkFrom").val() : "",
                "To_Date": $("#dpkTo").val() ? $("#dpkTo").val() : "",
            }

            let thongkeUrl = "/Api/ThongKeXuat.ashx?DataType=2&From_Date=" + thoiGianThongKe.From_Date + "&To_Date=" + thoiGianThongKe.To_Date;

            console.log("JSON", thoiGianThongKe)
            $.ajax({
                type: "GET",
                url: thongkeUrl,
                success: function (result) {
                    if (result.Status_Code == 0) {
                        //$('#alert').empty().append(`<div class='alert alert-success'>  <strong> Success! </strong >` + result.Status_Text + ` </div >`)

                      
                        $('#txtTotal').empty().append("Tổng cộng : "+result.Status_Text+" đ");

                        table.ajax.url(thongkeUrl).load();
                    }
                    else {
                        $('#alert').empty().append(`<div class='alert alert-danger'> <strong> Lỗi! </strong > ` + result.Status_Text + ` </div >`);
                          $('#alert').show();
                        // ẩn alert sau 7s
                        $("#alert").delay(7000).slideUp(200, function () {
                            $(this).alert('dispose');
                        });
                    }
                },
                error: function (result) {
                    $('#alert').empty().append(`<div class='alert alert-danger'> <strong> Lỗi! </strong > Có lỗi trong quá trình kết nối </div >`)
                    console.log(result)
                }
            });
        }

        function btnRefresh_OnClick(e) {
            e.preventDefault();
            table.ajax.url("/Api/ThongKeXuat.ashx?DataType=1").load();
        }

        $(document).ready(function () {
            loadTable()


            $("#btnThongKeTheoNgay").click(function (e) {
                btnThongKeTheoNgay_OnClick(e)
            })

            $("#btnRefresh").click(function (e) {
                btnRefresh_OnClick(e)
            })

            $('#dpkFrom').datepicker({
                uiLibrary: 'bootstrap4',
                format: 'dd/mm/yyyy'
            })

            $('#dpkTo').datepicker({
                uiLibrary: 'bootstrap4',
                format: 'dd/mm/yyyy',
            })
        });
    </script>

</asp:Content>
