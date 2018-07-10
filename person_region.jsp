<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>区域</title>
</head>
<body>
    <ul id="region" class="easyui-tree"></ul> 
    <script>
    $(function(){
/*         $('#region').tree({
            url: '${ctx}/person/region/list',
            checkbox: true,
            animate: true,
    		method : "POST",
    		onContextMenu: function(e,node){
                e.preventDefault();
                $(this).tree('select',node.target);
            }
        });     */

        var check_switch=false;
        
        $.ajax({
            type:'post',
            url:'${ctx}/person/region/list',
            success:function(data){
              $('#region').tree({
                   data:data.regionList,
                   checkbox: true,
                   animate: true,
                   lines : true,
                   cascadeCheck : false,
                   onBeforeLoad : function(node, param) {
                   	  check_switch=false;
                   },
                   onLoadSuccess : function(node, data) {
                   	  check_switch=true;
                   },
                   onCheck: function(node, checked){
                       console.log(check_switch)
                       check_switch = true;
                    	if(check_switch){
                        	check_switch = false;
                        		if(checked){
                        			var parent = $("#region").tree('getParent', node.target);
                        			if(parent){
                        				$('#region').tree('check', parent.target);
                        			}
                        		check_switch = true;//打开  父节点选中后
                         
                        	}else{
                        		cancelSubNode(node);//判断是否可以取消父节点
                         
                        		check_switch = true;
                        		//父节点取消选中，则uncheck所有子节点
                        		var children = $("#region").tree('getChildren', node.target);
                        		if(children){
                        			for(var i=0; i<children.length;i++){
                        				if(children[i]){
                        					$('#region').tree('uncheck', children[i].target);
                        				}
                        			}
                        		}
                        	}
                         
                        }
                    }                                
                }); 
            }
        });
        
        
        
        
        //判断父级节点是否可以 取消勾选
        function cancelSubNode(node){
        	var parent = $("#region").tree('getParent', node.target);   //当前节点的父节点
        	if(parent){
        		var subNodes = [];
        		$(parent.target).next().children().children("div.tree-node").each(function(){   
             	 	 	 subNodes.push($("#region").tree('getNode',this));
        		});
        		//判断是否可以取消  父级节点 的选中        
        		if(subNodes){
        			var falg=true; 
        			$.each(subNodes,function(){
        				if(this.checked){         //同级中有一个选中的 上级父节点 就不能取消选中
        					falg=false;
        				}
        			})
        			if(falg){
        				$('#region').tree('uncheck', parent.target);
        			}
        		}
        		return subNodes;
        	}
        }
                
        function getSubNode(node){
        	var parent = $("#region").tree('getParent', node.target);
        	if(parent){
        		var subNodes = [];
        		$(parent.target).next().children().children("div.tree-node").each(function(){   
               			 subNodes.push($("#region").tree('getNode',this));
        		 });
        	return subNodes;
        	}
        }
        
        
    })
     
    </script>
</body>
</html>