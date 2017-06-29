package com.banamex.nearshore.redis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.banamex.nearshore.catalogsms.controller.ProveedoresController.ZuulRedisClient;

@Service
public class RedisVariablesService{

    @Autowired
    private ZuulRedisClient zuulRedisClient;

    public Integer getVariables(@RequestBody String applicationId ){
        return zuulRedisClient.getProveedor(applicationId);
    }
}