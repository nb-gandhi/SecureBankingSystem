<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page session="true"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>View All</title>

    <!-- Bootstrap Core CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${pageContext.request.contextPath}/resources/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- Logout Script -->
    <script type="text/javascript">
        function formSubmit() {
            document.getElementById("logoutForm").submit();
        }
    </script>

</head>

<script>
document.onmousedown=disableclick;
status="Right Click Disabled";
function disableclick(event)
{
  if(event.button==2)
   {
     alert(status);
     return false;    
   }
}
</script>
<body oncontextmenu="return false">

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index"><font COLOR=RED> <b><sec:authentication property="principal.username" /></b> </font></a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <sec:authentication property="principal.username" /> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="javascript:formSubmit()"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            
            <!-- Logout feature implementation -->
            <c:url value="/j_spring_security_logout" var="logoutUrl" />
            <form action="${logoutUrl}" method="post" id="logoutForm">
                <input type="hidden" name="${_csrf.parameterName}"
                    value="${_csrf.token}" />
            </form>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li>
                        <a href="addUser"><i class="fa fa-fw fa-dashboard"></i> Add User</a>
                    </li>
                    <li>
                        <a href="viewQueue"><i class="fa fa-fw fa-dashboard"></i> View Queue</a>
                    </li>
                    <li class="active">
                        <a href="getList"><i class="fa fa-fw fa-dashboard"></i>View All Regular Employee</a>
                    </li>
                    <li>
                        <a href="changePassword"><i class="fa fa-fw fa-dashboard"></i>Change Password (SELF)</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                          View All
                        </h1>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i> User Details</h3>
                            </div>
            
                            <div class="panel-body">
                                <div id="morris-area-chart">
                                
                                        <c:if test="${not empty status}">
											<h4> ${status} </h4>
											<h4> <a href="getList">Get View All Customer List click here</a></h4>
	                                    </c:if> <br/> <br/>
                                <c:if test="${empty status}">
                                 <b> <u> <h4> LIST OF ALL USERS - </h4> </u> </b>
									  <table border="1">  
									   <tr>  
									    <td class="heading">User Name</td>  
									    <td class="heading">First Name</td>  
									    <td class="heading">Last Name</td>  
									    <td class="heading">Sex</td> 
									    <td class="heading">Contact Number</td>  
									    <td class="heading">Email</td>
									    <td class="heading">Address</td> 
									    <td class="heading">Modify</td>  
									    <td class="heading">Delete</td>  
									   </tr>  
									   <c:forEach var="user" items="${userList}">  
									    <tr>  
									     <td>${user.username}</td>  
									     <td>${user.firstname}</td>  
									     <td>${user.lastname}</td>   
									     <td>${user.sex}</td> 
									     <td>${user.phonenumber}</td>  
									     <td>${user.email}</td> 
									     <td>${user.address}</td>  
									     <td><form:form method="post" action="modifyUser" modelAttribute="accountNumber" autocomplete="off">                    
					                     <input type="hidden" name="modifyUser" id="accountNumber_RemoveUser" value="${user.username}" style="color:#999;" /><br/> <br/>
					                    <a> <input type="submit" style="margin-right: 5%" name="SearchUser" id="modifyUserButton" value="Update User" /></a> <br/> <br/>
					                        </form:form></td>  
									     <td> <form:form method="post" action="removeUserDB" modelAttribute="usernameSearch">					
										 <input type="hidden" name="account" id="accountNumber_RemoveUser" value="${user.username}" style="color:#999;" /><br/> <br/>
										 <a> <input type="submit" style="margin-right: 5%" name="SearchUser" id="removeUserButton" value="Remove User" /></a> <br/> <br/>
										 </form:form></td> 
									    </tr>  
									   </c:forEach>  
									   <tr><td colspan="11"><a href="addUser">Add New User</a></td></tr>  
									  </table>  
									  </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
                
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery Version 1.11.0 -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

</body>

</html>  
	