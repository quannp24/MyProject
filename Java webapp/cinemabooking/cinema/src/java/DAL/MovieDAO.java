/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Movie;

/**
 *
 * @author MSI
 */
public class MovieDAO extends DBContext {

    Connection conn = null;
    PreparedStatement pre = null;
    ResultSet rs = null;

    public ArrayList<Movie> top8Movies() {
        ArrayList<Movie> arr = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY StartDate DESC) AS Seq FROM Movie)t WHERE Seq BETWEEN 1 AND 8";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                Movie mov = new Movie(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4),
                        rs.getInt(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getDate(5));
                arr.add(mov);
            }
        } catch (Exception e) {
        }
        return arr;
    }

    public ArrayList<Movie> getNext4Movie(int num) {
        ArrayList<Movie> arr = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY StartDate DESC) AS Seq FROM Movie)t WHERE Seq BETWEEN ? AND ?";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setInt(1, num + 1);
            pre.setInt(2, num + 4);
            rs = pre.executeQuery();
            while (rs.next()) {
                Movie mov = new Movie(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4),
                        rs.getInt(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getDate(5));
                arr.add(mov);
            }
        } catch (Exception e) {
        }
        return arr;
    }

    public ArrayList<Movie> getMovieWithPagging(int page, int PAGE_SIZE) {
        ArrayList<Movie> list = new ArrayList<>();
        String query = "";
        try {
            /*Set up connection and Sql statement for Query*/
            query = "Select * from movie order by movieId\n"
                    + "offset (?-1)*? row fetch next ? rows only";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, page);
            pre.setInt(2, PAGE_SIZE);
            pre.setInt(3, PAGE_SIZE);
            /*Query and save in ResultSet*/
            rs = pre.executeQuery();

            /*Assign data to an arraylist of Movie*/
            while (rs.next()) {
                Movie m = new Movie();
                m.setMovieId(rs.getInt("MovieId"));
                m.setMovieName(rs.getString("MovieName"));
                m.setCategory(rs.getString("Category"));
                m.setStartdate(rs.getDate("StartDate"));
                m.setDuration(rs.getInt("Duration"));
                m.setLanguage(rs.getString("Language"));
                m.setRate(rs.getString("Rated"));
                m.setDescription(rs.getString("Description"));
                m.setImage(rs.getString("Img"));
                m.setEnddate(rs.getDate("EndDate"));
                list.add(m);
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return list;
    }

    public int getTotalMovie() {
        String query = "";

        try {
            /*Set up connection and Sql statement for Query*/
            query = "select count(MovieId) from Movie";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            /*Query and save in ResultSet*/
            rs = pre.executeQuery();

            /*Assign data to an arraylist of Movie*/
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return 0;
    }

    public void addMovie(Movie movie) {
        String query = "";
        try {

            query = "INSERT INTO [dbo].[Movie] ([MovieName],[Category],[StartDate],[Duration],[Language],[Rated],[Description],[Img],[EndDate])\n"
                    + "     VALUES (?,?,?,?,?,?,?,?,?)";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setString(1, movie.getMovieName());
            pre.setString(2, movie.getCategory());
            pre.setDate(3, movie.getStartdate());
            pre.setInt(4, movie.getDuration());
            pre.setString(5, movie.getLanguage());
            pre.setString(6, movie.getRate());
            pre.setString(7, movie.getDescription());
            pre.setString(8, movie.getImage());
            pre.setDate(9, movie.getEnddate());
            pre.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(Movie.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
    }

    public ArrayList<Movie> getMovieByName(String movieName) {
        ArrayList<Movie> list = new ArrayList<>();
        String query = "";
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select * from Movie where movieName like ?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setString(1, "%" + movieName.trim() + "%");


            /*Query and save in ResultSet*/
            rs = pre.executeQuery();

            /*Assign data to an arraylist of Movie*/
            while (rs.next()) {
                Movie m = new Movie();
                m.setMovieId(rs.getInt("MovieId"));
                m.setMovieName(rs.getString("MovieName"));
                m.setCategory(rs.getString("Category"));
                m.setStartdate(rs.getDate("StartDate"));
                m.setDuration(rs.getInt("Duration"));
                m.setLanguage(rs.getString("Language"));
                m.setRate(rs.getString("Rated"));
                m.setDescription(rs.getString("Description"));
                m.setImage(rs.getString("Img"));
                m.setEnddate(rs.getDate("EndDate"));
                list.add(m);
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return list;
    }

    public Movie getMovieById(int movieId) {
        String query = "";
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select * from Movie where MovieId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, movieId);

            rs = pre.executeQuery();

            if (rs.next()) {
                Movie m = new Movie();
                m.setMovieId(rs.getInt("MovieId"));
                m.setMovieName(rs.getString("MovieName"));
                m.setCategory(rs.getString("Category"));
                m.setStartdate(rs.getDate("StartDate"));
                m.setDuration(rs.getInt("Duration"));
                m.setLanguage(rs.getString("Language"));
                m.setRate(rs.getString("Rated"));
                m.setDescription(rs.getString("Description"));
                m.setImage(rs.getString("Img"));
                m.setEnddate(rs.getDate("EndDate"));
                return m;
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

    public void editMovie(Movie movie) {
        String query = "";
        try {
            query = "UPDATE [dbo].[Movie]\n"
                    + "   SET [MovieName] = ?\n"
                    + "      ,[Category] = ?\n"
                    + "      ,[StartDate] = ?\n"
                    + "      ,[Duration] = ?\n"
                    + "      ,[Language] = ?\n"
                    + "      ,[Rated] = ?\n"
                    + "      ,[Description] = ?\n"
                    + "      ,[Img] = ?\n"
                    + "      ,[EndDate] = ?\n"
                    + " WHERE MovieId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setString(1, movie.getMovieName());
            pre.setString(2, movie.getCategory());
            pre.setDate(3, movie.getStartdate());
            pre.setInt(4, movie.getDuration());
            pre.setString(5, movie.getLanguage());
            pre.setString(6, movie.getRate());
            pre.setString(7, movie.getDescription());
            pre.setString(8, movie.getImage());
            pre.setDate(9, movie.getEnddate());
            pre.setInt(10, movie.getMovieId());

            pre.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
    }

    public String getImgMovieById(int movieId) {
        String query = "";
        try {
            /*Set up connection and Sql statement for Query*/
            query = "select img from Movie where MovieId=?";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, movieId);

            rs = pre.executeQuery();

            if (rs.next()) {

                return rs.getString("img");
            }
        } catch (SQLException e) {
            /*Exeption Handle*/
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            /*Close connection, prepare statement, result set*/
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return null;
    }

    public void deleteMovie(int id) {
        try {
            String query = "DELETE FROM dbo.Movie WHERE movieId = ? ";
            conn = new DBContext().connection;
            pre = conn.prepareStatement(query);
            pre.setInt(1, id);
            pre.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(Movie.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
    }

    //inter 3
    public ArrayList<Movie> getMovieComingSoon() {
        ArrayList<Movie> arr = new ArrayList<>();
        String sql = "SELECT * FROM Movie where StartDate>CURRENT_TIMESTAMP";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                arr.add(new Movie(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4), rs.getInt(6),
                        rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getDate(5)));
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return arr;
    }

    public ArrayList<Movie> getMovieNowPlaying() {
        ArrayList<Movie> arr = new ArrayList<>();
        String sql = "SELECT * FROM Movie where StartDate<CURRENT_TIMESTAMP AND EndDate>CURRENT_TIMESTAMP";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                arr.add(new Movie(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4), rs.getInt(6),
                        rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getDate(5)));
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return arr;
    }

    public ArrayList<Movie> getMovies(Date date) {
        ArrayList<Movie> arr = new ArrayList<>();
        String sql = "SELECT * FROM Movie where StartDate<? AND EndDate>?";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setDate(1, date);
            pre.setDate(2, date);
            rs = pre.executeQuery();
            while (rs.next()) {
                arr.add(new Movie(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4), rs.getInt(6),
                        rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getDate(5)));
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return arr;
    }

    public ArrayList<Movie> getMoviesSlot(Date date, ArrayList<Integer> listMovieID) {
        ArrayList<Movie> arr = new ArrayList<>();
        String sql = "SELECT * FROM Movie where StartDate<? AND EndDate>?";
        try {
            conn = new DBContext().connection;
            pre = conn.prepareStatement(sql);
            pre.setDate(1, date);
            pre.setDate(2, date);
            rs = pre.executeQuery();
            while (rs.next()) {
                boolean check = false;
                for (Integer m : listMovieID) {
                    if (m == rs.getInt("MovieId")) {
                        check = true;
                        break;
                    }

                }
                if (!check) {
                    arr.add(new Movie(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4), rs.getInt(6),
                            rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getDate(5)));
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
            closeResultSet(rs);
        }
        return arr;
    }

}
