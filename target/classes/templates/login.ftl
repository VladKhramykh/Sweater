<#import "parts/common.ftl" as c><#import "parts/login.ftl" as l><#import "parts/loginPage.ftl" as lp><@c.page>    <h3>Login</h3>    <#if message??>        <div class="alert alert-${messageType}" role="alert">            ${message?ifExists}        </div>    </#if>    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>        <div class="alert alert-danger" role="alert">            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}        </div>    </#if>    <!-- Button trigger modal -->    <button type="button" class="btn link-a-l" data-toggle="modal" data-target="#SignIn">        Sign In    </button>    <button type="button" class="btn link-a-l" data-toggle="modal" data-target="#Reg">        Registration    </button>    <div class="modal fade bd-example-modal-lg" id="SignIn" tabindex="-1" role="dialog" aria-labelledby="SingIn" aria-hidden="true">        <div class="modal-dialog modal-dialog-centered" role="document">            <div class="modal-content">                <div class="modal-header">                    <h5 class="modal-title title" id="SgnInTitle">Sign in</h5>                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">                        <span aria-hidden="true">&times;</span>                    </button>                </div>                <div class="modal-body">                    <@lp.login "/login" />                </div>            </div>        </div>    </div>    <div class="modal fade bd-example-modal-lg" id="Reg" tabindex="-1" role="dialog" aria-labelledby="Registration" aria-hidden="true">        <div class="modal-dialog modal-dialog-centered" role="document">            <div class="modal-content dark-title">                <div class="modal-header dark-title">                    <h5 class="modal-title" id="SgnInTitle">Registration</h5>                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">                        <span aria-hidden="true">&times;</span>                    </button>                </div>                <div class="modal-body mx-3">                    <@l.login "/registration" true/>                </div>            </div>        </div>    </div></@c.page>