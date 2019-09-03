<#include "security.ftl"><#import "login.ftl" as l><nav class="navbar navbar-expand-lg navbar-dark bg-dark">    <a class="navbar-brand" href="/">Sweater</a>    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">        <span class="navbar-toggler-icon"></span>    </button>    <div class="collapse navbar-collapse" id="navbarSupportedContent">        <ul class="navbar-nav mr-auto">            <li class="nav-item mx-2">                <a class="nav-link" href="/">Home<span class="sr-only">(current)</span></a>            </li>            <#if user??>                <li class="nav-item mx-2">                    <a class="nav-link" href="/main">Messages<span class="sr-only">(current)</span></a>                </li>                <#if isAdmin>                <li class="nav-item mx-2">                    <a class="nav-link" href="/user">User list</a>                </li>                </#if>                <li class="nav-item mx-2">                    <a class="nav-link" href="/user/profile">Profile</a>                </li>                <li class="nav-item mx-2">                    <a class="nav-link" href="/user-messages/${currentUserId}">My messages</a>                </li>            </#if>        </ul>        <div class="navbar-text mr-4"><#if user??>${name}<#else>Please, login</#if></div>            <@l.logout />    </div></nav>