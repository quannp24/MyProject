using BusinessObject;
using DataAccess.DAO;
using DataAccess.IRepository;

namespace DataAccess.Repository
{
    public class AccountRepository : IAccountRepository
    {
        public Account GetAccByID(int accID) => AccountManagement.Instance.GetAccountByID(accID);

        public Account GetAccByUsername(string username) => AccountManagement.Instance.GetAccountByUsername(username);

        public Task InsertAccount(Account acc) => AccountManagement.Instance.AddNew(acc);

        public Account Login(string username, string password) => AccountManagement.Instance.GetAccountByUserPass(username, password);

        public Task UpdateAccount(Account acc) => AccountManagement.Instance.Update(acc);



    }
}
