package com.manong.service;

import pojo.EasyUITree;
import pojo.ResponseJsonResult;

import java.util.List;

public interface ProductCategoryService {
    List<EasyUITree> findProductCategoryByParentId(short parentid);

    ResponseJsonResult addCategory(Short parentid, String name);

    ResponseJsonResult deleteCategory(Short parentid, Short id);

    ResponseJsonResult editCategory(Short id, String name);
}
