<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Panel de Control - Selenium Firefox</title>
    <!-- Agregamos Bootstrap vía CDN para que se vea moderno y limpio -->
%{--    <link rel="stylesheet" href="https://bootstrapcdn.com">--}%
    <asset:javascript src="jquery-3.3.1.min.js"/>
    <asset:javascript src="bootstrap-3.3.2/bootstrap.js"/>
    <asset:javascript src="all.min.js"/>
    <asset:stylesheet src="fontawesome.min.css"/>
</head>
<body>
<div class="container mt-5" style="text-align: center">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0"><i class="fa fa-robot"></i> MFC automatizado con Selenium</h3>
        </div>
    </div>
</div>

<div class="container " style="text-align: center; margin-top: 20px">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
           <i class="fa fa-users"></i> Ingreso de compromiso de participación
        </div>
    </div>
    <div class="col-md-12 breadcrumb">
        <div class="col-md-4"></div>
        <div class="col-md-2">
            <label style="font-size: 16px">Número de la oferta</label>
        </div>
        <div class="col-md-1">
            <g:textField name="numero" id="numeroOferta" class="form-control" value="${1}"/>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-success" id="btnAceptar"><i class="fa fa-check"></i> Aceptar</a>
        </div>
    </div>
</div>


<div class="container " style="text-align: center; margin-top: 20px">
    <div class="card shadow">
        <div class="card-header bg-info text-white">
            <i class="fa fa-book"></i> Ingreso de experiencia laboral
        </div>
    </div>
    <div class="col-md-12 breadcrumb">
        <div class="col-md-3"></div>
        <div class="col-md-2">
            <label style="font-size: 16px">Número de la oferta</label>
        </div>
        <div class="col-md-1">
            <g:textField name="numeroOfertaExperiencia" id="numeroOfertaExperiencia" class="form-control" value="${1}"/>
        </div>
        <div class="col-md-3">
            <label style="font-size: 16px">Número del personal </label>
        </div>
        <div class="col-md-1">
            <g:textField name="numeroPersonal" id="numeroPersonal" class="form-control" value="${1}"/>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-success" id="btnCargarExperiencia"><i class="fa fa-check"></i> Aceptar</a>
        </div>
    </div>
</div>

<div class="container " style="text-align: center; margin-top: 20px">
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">
            <i class="fa fa-upload"></i> Cargar archivo de anexos
        </div>
    </div>
    <div class="col-md-12 breadcrumb">
        <div class="col-md-3"></div>
        <div class="col-md-2">
            <label style="font-size: 16px">Número de la oferta</label>
        </div>
        <div class="col-md-1">
            <g:textField name="numeroOfertaCargaArchivo" id="numeroOfertaCargaArchivo" class="form-control" value="${1}"/>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-success" id="btnCargarArchivo"><i class="fa fa-check"></i> Aceptar</a>
        </div>
    </div>
</div>


<div class="container " style="text-align: center; margin-top: 20px">
    <div class="card shadow">
        <div class="card-header bg-info text-white">
            <i class="fa fa-cog"></i> Ingreso experiencia del oferente
        </div>
    </div>
    <div class="col-md-12 breadcrumb">
        <div class="col-md-3"></div>
        <div class="col-md-2">
            <label style="font-size: 16px">Número de la oferta</label>
        </div>
        <div class="col-md-1">
            <g:textField name="numeroOfertaExperienciaOferente" id="numeroOfertaExperienciaOferente" class="form-control" value="${1}"/>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-success" id="btnCargarExperienciaOferente"><i class="fa fa-check"></i> Aceptar</a>
        </div>
    </div>
</div>



<script type="text/javascript">

    $("#btnAceptar").click(function () {
        var no = $("#numeroOferta").val();
        location.href="${createLink(controller: 'selenium', action: 'iniciar')}?id=" + no
    });

    $("#btnCargarExperiencia").click(function () {
        var numeroOferta = $("#numeroOfertaExperiencia").val();
        var numeroPersonal = $("#numeroPersonal").val();
        location.href="${createLink(controller: 'selenium', action: 'iniciarCargaExperienciaLaboral')}?id=" + numeroOferta + "&personal=" + numeroPersonal
    });

    $("#btnCargarArchivo").click(function () {
        var no = $("#numeroOfertaCargaArchivo").val();
        location.href="${createLink(controller: 'selenium', action: 'iniciarCargaAnexos')}?id=" + no
    });

    $("#btnCargarExperienciaOferente").click(function () {
        var no = $("#numeroOfertaExperienciaOferente").val();
        location.href="${createLink(controller: 'selenium', action: 'iniciarCargaExperienciaOferente')}?id=" + no
    });


</script>

</body>
</html>
