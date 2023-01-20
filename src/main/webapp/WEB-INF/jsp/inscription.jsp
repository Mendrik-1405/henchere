<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="extract.employer.*,java.io.File" %>
<%
    PersonneForm fpersonne = (PersonneForm) request.getAttribute("fpersonne");
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
    <link href="/assets/extra-libs/c3/c3.min.css" rel="stylesheet" type="text/css">
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
                                <div>
                                    <div class="customize-input">
                                        <input class="form-control custom-shadow custom-radius border-0 bg-white"
                                            type="search" placeholder="Search" aria-label="Search">
                                        <i class="form-control-icon" data-feather="search"></i>
                                    </div>
                                </div>
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
        <form id="persId"  onsubmit="submitForm(event)">
            <div class="page-wrapper">
                <div class="page-breadcrumb">
                    <div class="row">
                        <div class="col-7 align-self-center">
                            <h2 class="page-title text-truncate text-dark font-weight-medium mb-1">Données personnelles</h2>
                        </div>
                    </div>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div>
                                        <h4 class="card-title">Nom</h4>
                                        <input type="text" name="nom" class="form-control" placeholder="Votre nom">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Prénom</h4>
                                        <input type="text" name="prenom" class="form-control" placeholder="Votre prénom">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Date de naissance</h4>
                                        <input type="date" name="naissance" class="form-control" placeholder="Date de naissance">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Taille</h4>
                                        <input type="text" name="taille" class="form-control" placeholder="Votre taille">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Masse</h4>
                                        <input type="number" name="masse" class="form-control" placeholder="Votre masse">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Salaire</h4>
                                        <input type="number" name="salaire" class="form-control" placeholder="Votre masse">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Réligion</h4>
                                        <select name="religion.id" id="" class="custom-select">
                                            <%
                                                for(int i = 0; i < fpersonne.getReligion().size(); i++) {
                                                    %>
                                                        <option value="<%= fpersonne.getReligion().get(i).getId() %>">
                                                            <%= fpersonne.getReligion().get(i).getName() %>
                                                        </option>
                                                    <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Couleur</h4>
                                        <select name="couleur.id" id="" class="custom-select">
                                            <%
                                                for(int i = 0; i < fpersonne.getCouleurs().size(); i++) {
                                                    %>
                                                        <option value="<%= fpersonne.getCouleurs().get(i).getId() %>">
                                                            <%= fpersonne.getCouleurs().get(i).getName() %>
                                                        </option>
                                                    <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Contact</h4>
                                        <input type="tel" name="contact" class="form-control" placeholder="+261 33 658 69">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Email</h4>
                                        <input type="email" name="email" class="form-control" placeholder="votreemail@gmail.com">
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Niveau d'étude</h4>
                                        <select name="diplome.id" id="" class="custom-select">
                                            <%
                                                for(int i = 0; i < fpersonne.getDiplome().size(); i++) {
                                                    %>
                                                        <option value="<%= fpersonne.getDiplome().get(i).getId() %>">
                                                            <%= fpersonne.getDiplome().get(i).getName() %>
                                                        </option>
                                                    <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Genre</h4>
                                        <%
                                            for(int i = 0; i < fpersonne.getGenres().size(); i++) {
                                        %>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="genre.id"
                                                id="inlineRadio1" value="<%= fpersonne.getGenres().get(i).getId() %>">
                                            <label class="form-check-label" for="inlineRadio1"><%= fpersonne.getGenres().get(i).getName() %></label>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Combien de fois vous allez à l'église en 1 année ?</h4>
                                        <input type="number" name="frequence" class="form-control" placeholder="52">

                                    </div>
                                    <div class="mt-3">
                                        <h4 class="card-title">Résumé de la vie</h4>
                                            <div class="form-group mt-3">
                                                <textarea class="form-control" name="description" rows="3" placeholder="Une petite description..."></textarea>
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
                            <h2 class="page-title text-truncate text-dark font-weight-medium mb-1">Critère de sélection</h2>
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
                                        <input type="text" name="noteMin" class="form-control" placeholder="14.25">
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Age</h4>
                                                <div class="row">
                                                    <input type="hidden"  name="critere.age.critere" value="7">
                                                    <div class="col-6"><input type="number" name="critere.age.value1" class="form-control" placeholder="valeur1"></div>
                                                    <div class="col-6"><input type="number"  name="critere.age.value2" class="form-control" placeholder="valeur2"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.age.coeff">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Taille</h4>
                                                <div class="row">
                                                    <input type="hidden"  name="critere.taille.critere" value="12">
                                                    <div class="col-6"><input type="text" class="form-control" placeholder="valeur1" name="critere.taille.value1"></div>
                                                    <div class="col-6"><input type="text" class="form-control" placeholder="valeur2" name="critere.taille.value2"></div>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.taille.coeff">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Masse</h4>
                                                <div class="row">
                                                    <input type="hidden"  name="critere.masse.critere" value="21">
                                                    <div class="col-6"><input type="number" class="form-control" placeholder="valeur1" name="critere.masse.value1"></div>
                                                    <div class="col-6"><input type="number" class="form-control" placeholder="valeur2" name="critere.masse.value2"></div>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.masse.coeff">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Salaire</h4>
                                                <div class="row">
                                                    <input type="hidden"  name="critere.salaire.critere" value="28">
                                                    <div class="col-6"><input type="number" class="form-control" placeholder="valeur1" name="critere.salaire.value1"></div>
                                                    <div class="col-6"><input type="number" class="form-control" placeholder="valeur2" name="critere.salaire.value2"></div>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.salaire.coeff">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Couleur intervalle</h4>
                                                <div class="row">
                                                    <input type="hidden"  name="critere.couleur.critere" value="9">
                                                    <div class="col-6"><input type="number" class="form-control" placeholder="valeur1" name="critere.couleur.value1"></div>
                                                    <div class="col-6"><input type="number" class="form-control" placeholder="valeur2" name="critere.couleur.value2"></div>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.couleur.coeff">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Diplome generale</h4>
                                                <div class="row">
                                                    <input type="hidden"  name="critere.diplome.critere" value="212">
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.diplome.coeff">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Réligion generale</h4>
                                                <div class="row">
                                                    <input type="hidden"  name="critere.religion.critere" value="140">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.religion.coeff">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Réligion</h4>
                                                <div class="row ml-3" style="display: inline-block;">  
                                                <%
                                                    for(int i = 0; i < fpersonne.getReligion().size(); i++) {
                                                        %>
                                                            <div  style="margin-top:26px;">
                                                                <h6 class="card-subtitle hlist"><%= fpersonne.getReligion().get(i).getName() %></h6>
                                                                <input type="hidden" name="critere.religion<%= i %>.critere" value="77">
                                                                <input type="hidden" name="critere.religion<%= i %>.value1" value="<%= fpersonne.getReligion().get(i).getName() %>">
                                                            </div> 
                                                        <%
                                                    }
                                                %>      
                                                               
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.religion.coeff">
                                                <%
                                                    for(int i = 0; i < fpersonne.getReligion().size(); i++) {
                                                        %>
                                                            <input type="text" class="form-control" placeholder="5" name="critere.religion<%= i %>.coeff">
                                                        <%
                                                    }
                                                %>  
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Couleur</h4>
                                                <div class="row ml-3" style="display: inline-block;">          
                                                    <%
                                                        for(int i = 0; i < fpersonne.getCouleurs().size(); i++) {
                                                            %>
                                                                <div style="margin-top:26px;">
                                                                    <h6 class="card-subtitle hlist"><%= fpersonne.getCouleurs().get(i).getName() %></h6>
                                                                    <input type="hidden" name="critere.couleur<%= i %>.critere" value="135">
                                                                    <input type="hidden" name="critere.couleur<%= i %>.value1" value="<%= fpersonne.getCouleurs().get(i).getName() %>">
                                                                </div> 
                                                            <%
                                                        }
                                                    %>        
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5"  name="critere.couleur.coeff">
                                                <%
                                                            
                                                    for(int i = 0; i < fpersonne.getCouleurs().size(); i++) {
                                                        %>
                                                            <input type="text" class="form-control" placeholder="5"  name="critere.couleur<%= i %>.coeff">
                                                        <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-8">
                                            <div>
                                                <h4 class="card-title">Diplome</h4>
                                                <div class="row ml-3" style="display: inline-block;">  
                                                <%
                                                        for(int i = 0; i < fpersonne.getDiplome().size(); i++) {
                                                            %>
                                                                <div class="" style="margin-top:26px;">
                                                                    <h6 class="card-subtitle hlist"><%= fpersonne.getDiplome().get(i).getName() %></h6>
                                                                <input type="hidden" name="critere.diplome<%= i %>.critere" value="74">
                                                                <input type="hidden" name="critere.diplome<%= i %>.value1" value="<%= fpersonne.getDiplome().get(i).getName() %>">
                                                                </div> 
                                                            <%
                                                        }
                                                    %>                     
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div>
                                                <h4 class="card-title">Coefficient</h4>
                                                <input type="text" class="form-control" placeholder="5" name="critere.diplome.coeff">
                                                <%
                                                        for(int i = 0; i < fpersonne.getDiplome().size(); i++) {
                                                            %>
                                                                <input type="text" class="form-control" placeholder="5" name="critere.diplome<%= i %>.coeff">
                                                            <%
                                                        }
                                                    %>   
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-3" >
                                        <button class="btn btn-success btn-block" style="margin-top: 50px;" >S'inscrire</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script>
        const extract = (ans,key,formData) => {
            let i = 0;
            while (formData.get(key+i+".critere") != undefined) {
                ans.push({
                    critere : formData.get(key+i+".critere"),
                    value1 : formData.get(key+i+".value1"),
                    value2 : formData.get(key+i+".value2"),
                    coeff : formData.get(key+i+".coeff"),
                });
                i++;
            }
            return ans;
        }
        const submitForm = (event) => {
            event.preventDefault();
            let formData = new FormData(document.getElementById("persId"));
            let critere = [
                {
                    critere : formData.get("critere.age.critere"),
                    value1 : formData.get("critere.age.value1"),
                    value2 : formData.get("critere.age.value2"),
                    coeff : formData.get("critere.age.coeff"),
                },
                {
                    critere : formData.get("critere.taille.critere"),
                    value1 : formData.get("critere.taille.value1"),
                    value2 : formData.get("critere.taille.value2"),
                    coeff : formData.get("critere.taille.coeff"),
                },
                {
                    critere : formData.get("critere.masse.critere"),
                    value1 : formData.get("critere.masse.value1"),
                    value2 : formData.get("critere.masse.value2"),
                    coeff : formData.get("critere.masse.coeff"),
                },
                {
                    critere : formData.get("critere.salaire.critere"),
                    value1 : formData.get("critere.salaire.value1"),
                    value2 : formData.get("critere.salaire.value2"),
                    coeff : formData.get("critere.salaire.coeff"),
                },
                {
                    critere : formData.get("critere.couleur.critere"),
                    value1 : formData.get("critere.couleur.value1"),
                    value2 : formData.get("critere.couleur.value2"),
                    coeff : formData.get("critere.couleur.coeff"),
                },
                {
                    critere : formData.get("critere.diplome.critere"),
                    value1 : 0,
                    value2 : 0,
                    coeff : formData.get("critere.diplome.coeff"),
                },
                {
                    critere : formData.get("critere.religion.critere"),
                    value1 : 0,
                    value2 : 0,
                    coeff : formData.get("critere.religion.coeff"),
                }
            ];
            critere = extract(critere,"critere.religion",formData);
            critere = extract(critere,"critere.couleur",formData);
            critere = extract(critere,"critere.diplome",formData);
            let jsonData = {
                diplome : {
                    id : formData.get("diplome.id")
                },
                religion : {
                    id : formData.get("religion.id")
                } ,
                genre : {
                    id : formData.get("genre.id")
                },
                couleur : {
                    id : formData.get("couleur.id")
                },
                criteres : critere
            };
            for (let [key, value] of formData.entries()) {
                jsonData[key] = value;
            }
            console.log(jsonData);
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && 200 <= xhr.status && xhr.status <= 290) {
                    window.location.replace("/rencontre/personne/"+xhr.responseText);
                    // alert(xhr.responseText);
                }
            }
            xhr.open("PUT", "/api/personne", true);
            xhr.setRequestHeader("Content-Type", "application/json");
            xhr.send(JSON.stringify(jsonData));
        }
    </script>
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