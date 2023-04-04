package common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManager {
	
	public String upload(String savePath, MultipartFile file) {
		String filename = file.getOriginalFilename();
		//filename =>test.txt
		String onlyFilename = filename.substring(0, filename.lastIndexOf("."));//test
		String extention = filename.substring(filename.lastIndexOf("."));//.txt
		//실제 업로드할 파일명
		String filepath = null;
		//파일명이 중복됐을때 뒤에 붙일 숫자
		int count = 0;
		while(true) {
			if(count == 0) {
				//첫번째 검증인 경우 숫자붙이지 않음
				filepath = onlyFilename+extention;			//text.txt
			}else {
				filepath = onlyFilename+"_"+count+extention;//text_1.txt
			}
			File checkFile = new File(savePath+filepath);
			if(!checkFile.exists()) {
				break;
			}
			count++;
		}
		//파일명 중복체크 끝 -> 업로드파일명 확정 -> 파일업로드
		//2-2. 중복처리가 끝난 파일 업로드
		try {
			FileOutputStream fos = new FileOutputStream(savePath+filepath);
			//성능 향상을 위한 보조스트림 생성
			BufferedOutputStream bos = new BufferedOutputStream(fos);
			//파일업로드
			byte[] bytes = file.getBytes();
			bos.write(bytes);
			bos.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return filepath;
	}
	public void download(String savePath, String filename, HttpServletResponse response) {
	    File file = new File(savePath + filename);
	    try (FileInputStream fis = new FileInputStream(file);
	         BufferedInputStream bis = new BufferedInputStream(fis);
	         OutputStream out = response.getOutputStream()) {

	        // 파일 다운로드를 위한 설정
	        response.setContentType("application/octet-stream");
	        response.setHeader("Content-Disposition", "attachment;filename=" + filename);
	        response.setHeader("Content-Transfer-Encoding", "binary");

	        byte[] buffer = new byte[1024];
	        int readCount;
	        while ((readCount = bis.read(buffer)) != -1) {
	            out.write(buffer, 0, readCount);
	        }
	    } catch (FileNotFoundException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}


	public boolean deleteFile(String savePath, String filepath) {
		File delFile = new File(savePath+filepath);
		return delFile.delete();
	}
}

