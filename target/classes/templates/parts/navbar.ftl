<#include "security.ftl">
<#import "login.ftl" as l>
<nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark">
    <#if !user??>
        <a class="navbar-brand col-10" href="/">Sweater</a>
    </#if>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <#if user??>
            <ul class="navbar-nav mr-auto">
                <li class="nav-item mx-2">
                    <a class="navbar-brand" href="/main">Home<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item mx-2">
                    <a class="nav-link" href="/all-main">All news<span class="sr-only">(current)</span></a>
                </li>
                <#if isAdmin>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="/user">User list</a>
                    </li>
                </#if>
                <li class="nav-item mx-2">
                    <a class="nav-link" href="/user/profile">Profile</a>
                </li>
                <li class="nav-item mx-2">
                    <a class="nav-link" href="/user-messages/${currentUserId}">My messages</a>
                </li>
                <form class="nav-item form-inline logBut" method="get" action="/user/search">
                    <div class="search-wrapper">
                        <div class="input-holder">
                            <input type="text" class="search-input" placeholder="Type username to search" name="searchText" />
                            <button class="search-icon" onclick="searchToggle(this, event);"><span></span></button>
                        </div>
                        <span class="close" onclick="searchToggle(this, event);"></span>
                    </div>
                </form>
            </ul>

        <#--      <form class="form-inline my-2 mr-lg-0" method="get" action="/user/search">-->
        <#--        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="searchText">-->
        <#--        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>-->
        <#--        &lt;#&ndash;<button class="uk-button uk-button-secondary my-2 my-sm-0" type="submit">Search</button>&ndash;&gt;-->
        <#--      </form>-->
        </#if>
        <div class="navbar-text mr-1"><#if user??>${name}<#else>Please, login</#if></div>
        <@l.logout />
    </div>
</nav>