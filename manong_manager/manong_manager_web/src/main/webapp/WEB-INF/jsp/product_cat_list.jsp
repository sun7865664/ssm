<%--
  Created by IntelliJ IDEA.
  User: DIY
  Date: 2019/1/9
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<ul id="productCategory" class="easyui-tree"></ul>
<div id="mm" class="easyui-menu" style="width:120px;">
    <div onclick="append()" data-options="iconCls:'icon-add'">添加</div>
    <div onclick="rename()" data-options="iconCls:'icon-add'">修改</div>
    <div onclick="remove()" data-options="iconCls:'icon-remove'">删除</div>
</div>
<script type="text/javascript">
    $(function () {
        $('#productCategory').tree({
            url: "/product_category/list",
            onContextMenu: function(e, node){
                e.preventDefault();
                // select the node
                $('#productCategory').tree('select', node.target);
                // display context menu
                $('#mm').menu('show', {
                    left: e.pageX,
                    top: e.pageY
                });
            },
            onAfterEdit: function(node) {
                var _tree= $("#productCategory");
                if(node.id == 0) {
                    $.post("/product_category/add", {parentid:node.parentId, name:node.text}, function(data) {
                        if(data.status==200) {
                            _tree.tree('update', {
                                target: node.target,
                                id: data.msg
                            })
                        } else {
                            $.messager.alert("添加分类失败")
                        }
                    })
                } else {
                    $.post("/product_category/edit", {id:node.id, name:node.text}, function(data) {
                        if(data.status==200) {
                            _tree.tree('update', {
                                target: node.target,
                            })
                        } else {
                            $.messager.alert("修改分类失败")
                        }
                    })
                }
            }
        });
    })
    
    function append() {
        var selected = $('#productCategory').tree('getSelected');
        $('#productCategory').tree('append', {
            parent: (selected?selected.target:null),
            data: [{
                id: 0,
                parentId: selected.id,
                text: '新建分类'
            }]
        });

        var _node = $('#productCategory').tree("find", 0);
        $('#productCategory').tree("select", _node.target).tree("beginEdit",_node.target)
    }
    
    function rename() {
        var selected = $('#productCategory').tree('getSelected');
        $('#productCategory').tree('beginEdit', selected.target);
    }
    
    function remove() {
        var selected = $('#productCategory').tree('getSelected');

        $.post("/product_category/del", {parentid:selected.attributes, id:selected.id}, function(data) {
            if(data.status==200) {
                $('#productCategory').tree('remove', selected.target);
            } else {
                $.messager.alert("删除分类失败")
            }
        });
    }
</script>
</body>
</html>
