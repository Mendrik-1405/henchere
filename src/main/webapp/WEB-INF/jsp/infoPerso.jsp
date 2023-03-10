<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="extract.employer.*,java.io.File,java.util.ArrayList" %>
<%
    Personne fpersonne = (Personne) request.getAttribute("personne");
    Critere salaireCrt = fpersonne.extractValue(ECritere.Salaire); 
    Critere ageCrt = fpersonne.extractValue(ECritere.Age); 
    Critere tailleCrt = fpersonne.extractValue(ECritere.Taille); 
    Critere masseCrt = fpersonne.extractValue(ECritere.Masse); 
    ArrayList<Critere> couleurCrt = fpersonne.extractValues(ECritere.Couleur);
    ArrayList<Critere> religionCrt = fpersonne.extractValues(ECritere.Religion);
    ArrayList<Critere> diplomeCrt = fpersonne.extractValues(ECritere.Diplome);
%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/assets/images/favicon.png">
    <title>Adminmart Template - The Ultimate Multipurpose admin template</title>
    <!-- Custom CSS -->
    <link href="/assets/extra-libs/c3/c3.min.css" rel="stylesheet">
    <link href="/assets/libs/chartist/dist/chartist.min.css" rel="stylesheet">
    <link href="/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="/dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <header class="topbar" data-navbarbg="skin6">
            <nav class="navbar top-navbar navbar-expand-md">
                <div class="navbar-header" data-logobg="skin6">
                    <!-- This is for the sidebar toggle which is visible on mobile only -->
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i
                            class="ti-menu ti-close"></i></a>
                    <!-- ============================================================== -->
                    <!-- Logo -->
                    <!-- ============================================================== -->
                    <div class="navbar-brand">
                        <!-- Logo icon -->
                        <!-- <a href="index.html"> -->
                            <!-- <b class="logo-icon"> -->
                                <!-- Dark Logo icon -->
                                <!-- <img src="/assets/images/logo-icon.png" alt="homepage" class="dark-logo" /> -->
                                <!-- Light Logo icon -->
                                <!-- <img src="/assets/images/logo-icon.png" alt="homepage" class="light-logo" /> -->
                            <!-- </b> -->
                            <!--End Logo icon -->
                            <!-- Logo text -->
                            <!-- <span class="logo-text"> -->
                                <!-- dark Logo text -->
                                <!-- <img src="/assets/images/logo-text.png" alt="homepage" class="dark-logo" /> -->
                                <!-- Light Logo text -->
                                <!-- <img src="/assets/images/logo-light-text.png" class="light-logo" alt="homepage" /> -->
                            <!-- </span> -->
                        <!-- </a> -->
                    </div>
                    <!-- ============================================================== -->
                    <!-- End Logo -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Toggle which is visible on mobile only -->
                    <!-- ============================================================== -->
                    <a class="topbartoggler d-block d-md-none waves-effect waves-light" href="javascript:void(0)"
                        data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i
                            class="ti-more"></i></a>
                </div>
                <!-- ============================================================== -->
                <!-- End Logo -->
                <!-- ============================================================== -->
                <div class="navbar-collapse collapse" id="navbarSupportedContent">
                    <!-- ============================================================== -->
                    <!-- toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-left mr-auto ml-3 pl-1">
                        <!-- Notification -->
                        <li class="nav-item dropdown">
                            <!-- <a class="nav-link dropdown-toggle pl-md-3 position-relative" href="javascript:void(0)"
                                id="bell" role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                                <span><i data-feather="bell" class="svg-icon"></i></span>
                                <span class="badge badge-primary notify-no rounded-circle">5</span>
                            </a> -->
                            
                        </li>
                        <!-- End Notification -->
                        <!-- ============================================================== -->
                        <!-- create new -->
                        <!-- ============================================================== -->
                    </ul>
                    <!-- ============================================================== -->
                    <!-- Right side toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-right">
                        <!-- ============================================================== -->
                        <!-- Search -->
                        <!-- ============================================================== -->
                        <li class="nav-item d-none d-md-block">
                            <a class="nav-link" href="javascript:void(0)">
                                <form>
                                    <div class="customize-input">
                                        <input class="form-control custom-shadow custom-radius border-0 bg-white"
                                            type="search" placeholder="Search" aria-label="Search">
                                        <i class="form-control-icon" data-feather="search"></i>
                                    </div>
                                </form>
                            </a>
                        </li>
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                    </ul>
                </div>
            </nav>
        </header>
        <aside class="left-sidebar" data-sidebarbg="skin6">
            <!-- Sidebar scroll-->
            <div class="scroll-sidebar" data-sidebarbg="skin6">
                <!-- Sidebar navigation-->
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <li class="sidebar-item"> <a class="sidebar-link sidebar-link" href="index.html"
                                aria-expanded="false"><i data-feather="home" class="feather-icon"></i><span
                                    class="hide-menu">Info perso</span></a></li>
                        <li class="list-divider"></li>
                        <li class="sidebar-item"> <a class="sidebar-link sidebar-link" href="index.html"
                                aria-expanded="false"><i data-feather="home" class="feather-icon"></i><span
                                    class="hide-menu">Personne Compatible</span></a></li>
                        <li class="list-divider"></li>
                    </ul>
                </nav>
                <!-- End Sidebar navigation -->
            </div>
            <!-- End Sidebar scroll-->
        </aside>
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h2 class="page-title text-truncate text-dark font-weight-medium mb-1">A propos</h2>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6">
                                        <div>
                                            <h4 class="card-title">Nom</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getNom() %></h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Pr??nom</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getPrenom() %></h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Date de naissance</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getNaissance() %></h6>
                                            <h6 class="card-subtitle"><%= fpersonne.getAge() %> ans</h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Taille</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getTaille() %> m</h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Masse</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getMasse() %> kg</h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">R??ligion</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getReligion().getName() %></h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Couleur</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getCouleur().getName() %></h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Contact</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getContact() %></h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Email</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getEmail() %></h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Niveau d'??tude</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getDiplome().getName() %></h6>
                                        </div>
                                        <div class="mt-3">
                                            <h4 class="card-title">Fr??quence ?? l'??glise</h4>
                                            <h6 class="card-subtitle"><%= fpersonne.getFrequence() %></h6>
                                        </div>
                                    </div>
                                    <div class="mt-3 col-6">
                                        <h4 class="card-title">R??sum?? de la vie</h4>
                                        <div>
                                        <%= fpersonne.getDescription() %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-wrapper">
            <div class="page-breadcrumb" style="margin-top: -100px;">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h2 class="page-title text-truncate text-dark font-weight-medium mb-1">Crit??re</h2>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div>
                                    <h4 class="card-title">Note minimum</h4>
                                    <h6 class="card-subtitle"><%= fpersonne.getNoteMin() %></h6>
                                </div>
                                <%
                                if(ageCrt != null) {
                                %>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Age</h4>
                                            <h6 class="card-subtitle">
                                            <%= ageCrt.getValue1() %>-
                                            <%= ageCrt.getValue2() %> 
                                            ans</h6>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Coefficient</h4>
                                            <h6 class="card-subtitle">
                                            <%= ageCrt.getCoeff() %>
                                            </h6>
                                        </div>
                                    </div>
                                </div>
                                <%
                                }
                                if (tailleCrt != null) {
                                %>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Taille</h4>
                                            <h6 class="card-subtitle">
                                            <%= tailleCrt.getValue1() %>-
                                            <%= tailleCrt.getValue2() %> m</h6>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title" style="color:transparent;">s</h4>
                                            <h6 class="card-subtitle">
                                            <%= tailleCrt.getCoeff() %>
                                            </h6>
                                        </div>
                                    </div>
                                </div>
                                <%
                                }
                                if (masseCrt != null) {
                                %>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Masse</h4>
                                            <h6 class="card-subtitle">
                                            <%= masseCrt.getValue1() %>-
                                            <%= masseCrt.getValue2() %>
                                            kg</h6>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title" style="color:transparent;">s</h4>
                                            <h6 class="card-subtitle"><%= masseCrt.getCoeff() %></h6>
                                        </div>
                                    </div>
                                </div>
                                <%
                                }
                                %>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Couleur</h4>
                                            <%
                                                for(int i = 0; i < couleurCrt.size(); i++) {
                                                    %>
                                                        <h6 class="card-subtitle"><%= couleurCrt.get(i).getValue1() %></h6>
                                                    <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title" style="color:transparent;">s</h4>
                                            <%
                                                for(int i = 0; i < couleurCrt.size(); i++) {
                                                    %>
                                                        <h6 class="card-subtitle"><%= couleurCrt.get(i).getCoeff() %></h6>
                                                    <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    if(salaireCrt != null) {
                                %>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Salaire</h4>
                                            <h6 class="card-subtitle">
                                            <%= salaireCrt.getValue1() %>-
                                            <%= salaireCrt.getValue2() %> ar</h6>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title" style="color:transparent;">s</h4>
                                            <h6 class="card-subtitle"><%= salaireCrt.getCoeff() %></h6>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Niveau d'etude</h4>
                                            <%
                                                for(int i = 0; i < diplomeCrt.size(); i++) {
                                                    %>
                                                        <h6 class="card-subtitle"><%= diplomeCrt.get(i).getValue1() %></h6>
                                                    <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title" style="color:transparent;">s</h4>
                                            <%
                                                for(int i = 0; i < diplomeCrt.size(); i++) {
                                                    %>
                                                        <h6 class="card-subtitle"><%= diplomeCrt.get(i).getCoeff() %></h6>
                                                    <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title">Religion</h4>
                                            <%
                                                for(int i = 0; i < religionCrt.size(); i++) {
                                                    %>
                                                        <h6 class="card-subtitle"><%= religionCrt.get(i).getValue1() %></h6>
                                                    <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mt-3">
                                            <h4 class="card-title" style="color:transparent;">s</h4>
                                            <%
                                                for(int i = 0; i < religionCrt.size(); i++) {
                                                    %>
                                                        <h6 class="card-subtitle"><%= religionCrt.get(i).getCoeff() %></h6>
                                                    <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-6">
                                        <a href="/recontre/personne/<%= fpersonne.getId() %>/compatible" class="btn btn-block btn-success">Voir les personnes compatibles</a>
                                    </div>
                                    <div class="col-6">
                                        <button class="btn btn-block btn-info">Modifier les informations personnelles</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="/assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- apps -->
    <!-- apps -->
    <script src="/dist/js/app-style-switcher.js"></script>
    <script src="/dist/js/feather.min.js"></script>
    <script src="/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="/dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="/dist/js/custom.min.js"></script>
    <!--This page JavaScript -->
    <script src="/assets/extra-libs/c3/d3.min.js"></script>
    <script src="/assets/extra-libs/c3/c3.min.js"></script>
    <script src="/assets/libs/chartist/dist/chartist.min.js"></script>
    <script src="/assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
    <script src="/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.min.js"></script>
    <script src="/assets/extra-libs/jvector/jquery-jvectormap-world-mill-en.js"></script>
    <script src="/dist/js/pages/dashboards/dashboard1.min.js"></script>
</body>