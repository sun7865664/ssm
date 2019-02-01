package com.manong.controller;

import com.manong.service.ProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.EasyUITree;
import pojo.ResponseJsonResult;

import java.util.List;

/**
 * 商品分类管理控制器
 */
@Controller
@RequestMapping("/product_category")
public class ProductCategoryController {

    @Autowired
    ProductCategoryService productCategoryService;

    /**
     *根据parentid返回数据列表
     */
    @RequestMapping("/list")
    @ResponseBody
    public List<EasyUITree> findProductCategoryByParentId(@RequestParam(value="id", defaultValue = "0") Short parentId){
        return productCategoryService.findProductCategoryByParentId(parentId);
    }
    /**
     * 添加分类
     */
    @RequestMapping("/add")
    @ResponseBody
    public ResponseJsonResult addCategory(Short parentid,String name) {
        ResponseJsonResult responseJsonResult = productCategoryService.addCategory(parentid, name);
        return responseJsonResult;
    }
    /**
     * 添加分类
     */
    @RequestMapping("/edit")
    @ResponseBody
    public ResponseJsonResult editCategory(Short id,String name) {
        ResponseJsonResult responseJsonResult = productCategoryService.editCategory(id, name);
        return responseJsonResult;
    }
    /**
     * 删除分类
     */
    @RequestMapping("/del")
    @ResponseBody
    public ResponseJsonResult deleteCategory(Short parentid, Short id) {
        ResponseJsonResult responseJsonResult = productCategoryService.deleteCategory(parentid, id);
        return responseJsonResult;
    }
}
