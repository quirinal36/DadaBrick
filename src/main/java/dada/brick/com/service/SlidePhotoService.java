package dada.brick.com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dada.brick.com.dao.SlidePhotoDAO;
import dada.brick.com.vo.SlidePhotoInfo;

@Component("slidePhotoService")
public class SlidePhotoService implements DataService<SlidePhotoInfo> {
	@Autowired
	SlidePhotoDAO dao;
	
	@Override
	public int insert(SlidePhotoInfo input) {
		return dao.insert(input);
	}

	@Override
	public int update(SlidePhotoInfo input) {
		return dao.update(input);
	}

	@Override
	public int delete(SlidePhotoInfo input) {
		return dao.delete(input);
	}

	@Override
	public List<SlidePhotoInfo> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SlidePhotoInfo> select(SlidePhotoInfo input) {
		return dao.select(input);
	}

	@Override
	public SlidePhotoInfo selectOne(SlidePhotoInfo input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(SlidePhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
