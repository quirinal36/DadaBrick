package dada.brick.com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dada.brick.com.dao.VideoInfoDAO;
import dada.brick.com.vo.VideoInfo;

@Component("VideoInfoService")
public class VideoInfoService implements DataService<VideoInfo> {
	@Autowired
	VideoInfoDAO dao;
	
	@Override
	public int insert(VideoInfo input) {
		return dao.insert(input);
	}

	@Override
	public int update(VideoInfo input) {
		return 0;
	}

	@Override
	public int delete(VideoInfo input) {
		return dao.delete(input);
	}

	@Override
	public List<VideoInfo> select() {
		return null;
	}

	@Override
	public List<VideoInfo> select(VideoInfo input) {
		return dao.select(input);
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
