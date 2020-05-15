package dada.brick.com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dada.brick.com.vo.SlidePhotoInfo;

@Repository("SlidePhotoDAO")
public class SlidePhotoDAO implements DataAccess<SlidePhotoInfo> {
	@Autowired
	SqlSessionTemplate sqlSession;
	final String namespace = "slide_photo_sql";
	
	@Override
	public int insert(SlidePhotoInfo input) {
		return sqlSession.insert(namespace+".insert", input);
	}

	@Override
	public int update(SlidePhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(SlidePhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<SlidePhotoInfo> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SlidePhotoInfo> select(SlidePhotoInfo input) {
		return sqlSession.selectList(namespace +".select", input);
	}

	@Override
	public SlidePhotoInfo selectOne(SlidePhotoInfo input) {
		return sqlSession.selectOne(namespace+".select_one", input);
	}

	@Override
	public int count(SlidePhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
