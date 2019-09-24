package com.cn.myblog.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;

public class FileIO {

	// 读取相应温行内容
	public String fileRead(File file) throws IOException {
		FileInputStream inputStream = new FileInputStream(file);
		InputStreamReader streamReader = new InputStreamReader(inputStream, "GBK");
		BufferedReader br = new BufferedReader(streamReader);
		String text = null;
		String textContent = "";
		while ((text = br.readLine()) != null) {
			textContent += text;
			textContent += "\n";
		}
//		System.out.println("此为文章内容" + textContent);
		br.close();
		streamReader.close();
		inputStream.close();
		return textContent;
	}

	// 保存文章在服务器
	public int fileWrite(String textContent, Integer typeId, int id) throws IOException {
		String type = "";
		if(typeId==1) {
			type="设计";
		}else if(typeId==2) {
			type="前端";
		}else if(typeId==3) {
			type="后端";
		}else if(typeId==4) {
			type="工具资源";
		}else if(typeId==5){
			type="bug记录";
		}else {
			type="经验总结";
		}
		char[] buffer = new char[32];
		int hasread;
		String appendString = "";
		System.out.println("服务器保存文章的内容为：" + textContent);
		File newfile = new File("E:/MyBlog/" + type);
		File fileParent = newfile.getParentFile();
		if (!fileParent.exists()) {
			fileParent.mkdirs();
			}
		if (!newfile.exists()) {
			System.out.println("创建文件夹"+newfile.mkdir());
		}
		File newtext = new File("E:/MyBlog/" + type + "/" + id);
		if (!newtext.exists()) {
			System.out.println(newtext.getAbsolutePath());
			newtext.createNewFile();
			System.out.println("创建文件成功！！！！！！！");
		}
		FileOutputStream outputStream = new FileOutputStream(newtext);
		OutputStreamWriter streamWriter = new OutputStreamWriter(outputStream, "GBK");
		StringReader stringReader = new StringReader(textContent);
		while ((hasread = stringReader.read(buffer)) > 0) {
			appendString = new String(buffer, 0, hasread);
//			System.out.println(appendString);
			streamWriter.write(appendString);
		}
		stringReader.close();
		streamWriter.close();
		outputStream.close();
		return 1;
	}

	// 删除保存在服务器的文件
	public int deleteFile(Integer typeId, int id) throws IOException {
		File newfile = new File("E:/MyBlog/" + typeId);
		File newtext;
		// 删除已有文件
		if (newfile.exists()) {
			newtext = new File("E:/MyBlog/" + typeId + "/" + id);
			if (newtext.exists()) {
				newtext.delete();
			}
		}
		return 1;
	}

	// 更改文章的分类
	public int changeFile(String lastType, Integer typeId, int id) throws IOException {
		String type1 = "";
		if(typeId==1) {
			type1="设计";
		}else if(typeId==2) {
			type1="前端";
		}else if(typeId==3) {
			type1="后端";
		}else if(typeId==4) {
			type1="工具资源";
		}else if(typeId==5){
			type1="bug记录";
		}else {
			type1="经验总结";
		}
		String type2 = "";
		if("1".equals(lastType)) {
			type2="设计";
		}else if("2".equals(lastType)) {
			type2="前端";
		}else if("3".equals(lastType)) {
			type2="后端";
		}else if("4".equals(lastType)) {
			type2="工具资源";
		}else if("5".equals(lastType)){
			type2="bug记录";
		}else {
			type2="经验总结";
		}
		File agoFile = new File("E:/MyBlog/" + type1+ "/"+id);
		File newFile;
		String textContent = "";
		FileIO fileIO = new FileIO();
		// 删除出已有文件
		if (agoFile.exists()) {
			agoFile.delete();
			newFile = new File("E:/MyBlog/" + type2 + "/" + id);
			if (newFile.exists()) {
				textContent = fileIO.fileRead(newFile);
//				System.out.println("文件是否删除成功" + newFile.delete());
			}
		}
		fileIO.fileWrite(textContent, Integer.parseInt(lastType), id);
		return 1;
	}

}
