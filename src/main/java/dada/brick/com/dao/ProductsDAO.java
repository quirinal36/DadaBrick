package dada.brick.com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dada.brick.com.vo.ProductsVO;

@Repository("ProductsDAO")
public class ProductsDAO implements DataAccess<ProductsVO> {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	final String namespace = "products_sql";
	
	@Override
	public int insert(ProductsVO input) {
		return sqlSession.insert(namespace+".insert", input);
	}
	@Override
	public int update(ProductsVO input) {
		return sqlSession.update(namespace +".update", input);
	}

	@Override
	public int delete(ProductsVO input) {
		return -1;
	}

	@Override
	public List<ProductsVO> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductsVO> select(ProductsVO input) {
		return sqlSession.selectList(namespace +".select", input);
	}

	@Override
	public ProductsVO selectOne(ProductsVO input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(ProductsVO input) {
		return sqlSession.selectOne(namespace+".count", input);
	}

	public ProductsVO selectPrev(ProductsVO input) {
		return sqlSession.selectOne(namespace +".select_prev", input);
	}
	
	public ProductsVO selectNext(ProductsVO input) {
		return sqlSession.selectOne(namespace +".select_next", input);
	}
	public int update(List<ProductsVO> input) {
		return sqlSession.update(namespace +".update_list", input);
	}
}
