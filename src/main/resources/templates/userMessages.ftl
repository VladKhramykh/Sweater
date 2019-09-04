<#import "parts/common.ftl" as c><#import "parts/messageEdit.ftl" as e /><@c.page>    <h3>${userChannel.username}</h3>    <#if !isCurrentUser>        <#if isSubscriber>            <a class="btn btn-secondary my-3" href="/user/unsubscribe/${userChannel.id}">Unsubscribe</a>        <#else >            <a class="btn btn-secondary my-3" href="/user/subscribe/${userChannel.id}">Subscribe</a>        </#if>    </#if>    <div class="container mt-4">        <div class="row">            <div class="col">                <div class="card">                    <div class="card-body">                        <div class="card-title">Subscriptions</div>                        <h3 class="card-text">                            <a href="/user/subscriptions/${userChannel.id}/list">${subscriptionsCount}</a>                        </h3>                    </div>                </div>            </div>            <div class="col">                <div class="card">                    <div class="card-body">                        <div class="card-title">Subscribers</div>                        <h3 class="card-text">                            <a href="/user/subscribers/${userChannel.id}/list">${subscribersCount}</a>                        </h3>                    </div>                </div>            </div>        </div>    </div>    <div class="container my-3">        <#if isCurrentUser>            <@e.addNewMessage false />        </#if>    </div>    <#include "parts/messageList.ftl" /></@c.page>