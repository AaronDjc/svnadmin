package org.svnadmin.util.list;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页类
 * @author YueXiaoYun
 *
 * @param <T>
 */
public class PagedList<T>
{

	 /**
	  * 分页类
	  * @param count 数据总数
	  * @param pageindex 当前页 
	  * @param pagesize 每页显示多少
	  * @param list 数据集
	  */
	 public PagedList(int count,int pageindex,int pagesize,List<T> list){
		 this.totalItemCount = count;
		 this.currentPageIndex = pageindex;
		 this.pageSize = pagesize;
		 this.list = list;
		 totalPageCount = (int)Math.ceil(count/(double)pagesize);
		 startRecordIndex=(pageindex - 1) * pagesize + 1;
         endRecordIndex = totalItemCount > pageindex * pagesize ?pageindex * pagesize : totalItemCount;
         
         pageList = new ArrayList<Integer>();
         int extendPage = 6;
         int countPage = totalPageCount, curPage = currentPageIndex;
         
         int startPage = 1, endPage = 1;
         if (countPage > extendPage)
         {
             if (curPage - (extendPage / 2) > 0)
             {
                 if (curPage + (extendPage / 2) < countPage)
                 {
                     startPage = curPage - (extendPage / 2);
                     endPage = startPage + extendPage - 1;
                 }
                 else
                 {
                     endPage = countPage;
                     startPage = endPage - extendPage + 1;

                 }
             }
             else
             {
                 endPage = extendPage;
             }
         }
         else
         {
             startPage = 1;
             endPage = countPage;
         }
         if (endPage > countPage) endPage = countPage;
         for (int i = startPage; i <= endPage; i++)
         {
        	 pageList.add(i);
         }
	 }
	 	 
	 private List<T> list;
	 protected int totalItemCount;
	 protected int currentPageIndex;
	 protected int pageSize;
	 protected int totalPageCount;
	 protected int startRecordIndex;
	 protected int endRecordIndex;
	 protected List<Integer> pageList; 
	 public List<T> getList(){
		 return this.list;
	 }
	 public List<Integer> getPageList(){
		 return this.pageList;
	 }
	 public int getTotalItemCount(){
		 return this.totalItemCount;
	 }
	 public int getCurrentPageIndex(){
		 return this.currentPageIndex;
	 }
	 public int getPageSize(){
		 return this.pageSize;
	 }
	 public int getTotalPageCount(){
		 return totalPageCount;
	 }
	 public int getStartRecordIndex(){
		 return startRecordIndex;
	 }
	 public int getEndRecordIndex(){
		 return endRecordIndex;
	 }
}
