package dada.brick.com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dada.brick.com.vo.VideoInfo;

@Repository("VideoInfoDAO")
public class VideoInfoDAO implements DataAccess<VideoInfo> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "video_info_sql";
	
	@Override
	public int insert(VideoInfo input) {
		return sqlSession.insert(namespace + ".insert", input);
	}

	@Override
	public int update(VideoInfo input) {
		return 0;
	}

	@Override
	public int delete(VideoInfo input) {
		return sqlSession.delete(namespace +".delete", input);
	}

	@Override
	public List<VideoInfo> select() {
		return null;
	}

	@Override
	public List<VideoInfo> select(VideoInfo input) {
		return sqlSession.selectList(namespace + ".select", input);
	}

	@Override
	public VideoInfo selectOne(VideoInfo input) {
		return null;
	}

	@Override
	public int count(VideoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
