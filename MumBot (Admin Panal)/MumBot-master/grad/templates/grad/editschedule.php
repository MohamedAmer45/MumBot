<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin - Edit Schedule</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    
    <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <?php include("includes/sidebar.php"); ?>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
				
                <?php include("includes/navbar.php"); ?>
                
                <!-- Begin Page Content -->
                <div class="container-fluid">
					
                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-5 text-gray-800">Edit Parenting Specialist Schedule</h1>
                       
                    </div>

                    
                   

            <div class="col-xl-12 col-lg-12 col-md-12">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body">
                    
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            
                            <div class="col-lg-12">
                                <div class="p-1">
                                	<div class="text-center m-3"><i class="fas fa-fw fa-calendar-alt fa-5x"></i></div>
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Edit Parenting Specialist Schedule</h1>
                                    </div>
                                    
                                    <div class="text-center col-lg-12">
                                        <label>Parenting Specialist ID: <span class="text-info">20548484</span></label><hr>
                                        <label>Full Name: <span class="text-info">Dr. Ahmed Samir Mohamed Shehata</span></label><hr>
                                        <label>Email: <span class="text-info">ahmedsamir@mumbot.com</span></label><hr>
                                        <label>Mobile Number: <span class="text-info">+201018888778</span></label><hr>
                                    </div>
                                    
                                   
                                    <div class="form-group row">
                                     
                                      <div class="offset-4 col-sm-4 mb-3 mb-sm-0">     
                                       
                                        <select class="form-control" id="userTypeSelect" name="weekDaySelect">
                                            <option selected disabled>Select Week Day...</option>
                                            <option value="1">Saturday</option>
                                            <option value="2">Sunday</option>
                                            <option value="3">Monday</option>
                                            <option value="4">Tuesday</option>
                                            <option value="5">Wednesday</option>
                                            <option value="6">Thursday</option>
                                            <option value="7">Friday</option>
                                         </select>
                                       </div>    
                                </div>
                                
                                <div class="table-responsive" id="dailyTimingsTbl" style="display:none;">
                                <table class="table table-bordered text-gray-900 table-hover" width="100%" cellspacing="0" id="tblWeekDays">
                                    <thead class="bg-gradient-light text-center">
                                        <tr>
                                            <th>Time Slot #</th>
                                            <th>Start Time</th>
                                            <th>End Time</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                        <tr class="bg-gradient-light text-center text-lg">
                                            
                                            <td>#1</td>
                                            <td>09:00</td>
                                            <td>12:00</td>   
                                            
                                            <td><button class="btn btn-danger" onclick="timingDelete(this);"><i class="fas fa-fw fa-trash-alt"></i>Delete Time Slot</button></td>

                                        </tr>
                                        <tr class="bg-gradient-light text-center text-lg">
                                            
                                            <td>#2</td>
                                            <td>14:00</td>
                                            <td>17:00</td>   
                                            
                                            <td><button class="btn btn-danger" onclick="timingDelete(this);"><i class="fas fa-fw fa-trash-alt"></i>Delete Time Slot</button></td>

                                        </tr>
                                        <tr class="bg-gradient-light text-center text-lg">
                                            
                                            <td>#3</td>
                                            <td>18:00</td>
                                            <td>20:00</td>   
                                            
                                            <td><button class="btn btn-danger" onclick="timingDelete(this);"><i class="fas fa-fw fa-trash-alt"></i>Delete Time Slot</button></td>

                                        </tr>
                                       
                                    </tbody>
                                </table>
                                <div class="offset-4 col-lg-4">
                                
                                <form>
                                <div class="form-group row">
                                	<div class="col-sm-6 mb-3 mb-sm-0">
                                		<input type="text" class="form-control m-2" placeholder="Start time..." id="stTime">
                                    </div>
                                    
                                    <div class="col-sm-6">
                                		<input type="text" class="form-control m-2" placeholder="End time..." id="endTime">
                                    </div>
                                </div> 
                                
                                <div class="offset-3">
                                	   
                                	<button class="btn btn-success" id="addBtn" type="button"><i class="fas fa-fw fa-plus-circle"></i>Add Time Slot</button>								
                                </div>					
                                </form>
                                </div>
                                <div class="text-center m-5">
                                <a href="schedules.php">&larr; Back</a>
                                </div>
                            </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        
                    

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; MumBot 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Do you really want to logout?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script type="text/javascript">
		$(document).ready(function () {
		   "use strict";
		   $("html, body").animate({ scrollTop: $(document).height() }, 1000);
		});
		
		$('[name=weekDaySelect]').change(function(){
    		"use strict";
       		$('#dailyTimingsTbl').fadeIn();
			$("html, body").animate({ scrollTop: $(document).height()-800 }, 1000);
    
		});
		
		function timingDelete(ctl) {
    		$(ctl).parents("tr").remove();
		}

		
		$('#addBtn').click(function(){
        	$('#tblWeekDays').append("<tr class='bg-gradient-light text-center text-lg'>" + '<td>#4</td>' +
                                            '<td>' + $("#stTime").val() + '</td>' +
                                            '<td>' + $("#endTime").val() + '</td>' +
											'<td>' + 
											"<button class='btn btn-danger' onclick='timingDelete(this);' >" +
											"<i class='fas fa-fw fa-trash-alt'>" +
											"</i>Delete Time Slot" +
											"</button>" +
											'</td>' +
											 
			 '</tr>');
    	});
    </script>

    <!-- Page level custom scripts -->
    <script src="js/demo/datatables-demo.js"></script>

</body>

</html>