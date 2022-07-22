
using BusinessObject;
using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class MemberDAO
    {
        private static MemberDAO instance = null;
        private static readonly object instanceLock = new object();
        private MemberDAO() { }
        public static MemberDAO Instance
        {
            get
            {
                lock (instanceLock)
                {
                    if (instance == null)
                    {
                        instance = new MemberDAO();
                    }
                    return instance;
                }
            }
        }

        public IEnumerable<Member> GetMemberList()
        {
            var mems = new List<Member>();
            try
            {
                using var context = new FStoreContext();
                mems = context.Members.ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return mems;
        }



        public Member GetMemberByID(int memberID)
        {
            Member mem = null;
            try
            {
                using var context = new FStoreContext();
                mem = context.Members.SingleOrDefault(c => c.MemberId == memberID);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return mem;
        }

        public Member GetMemberByAccount(string email, string password)
        {
            Member mem = null;
            try
            {
                using var context = new FStoreContext();
                mem = context.Members.SingleOrDefault(c => c.Email == email && c.Password == password);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return mem;
        }

        public void AddNew(Member member)
        {
            try
            {
                Member mem = GetMemberByID(member.MemberId);
                if (mem == null)
                {
                    using var context = new FStoreContext();
                    context.Members.Add(member);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The member is already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void Update(Member mem)
        {
            try
            {
                Member member = GetMemberByID(mem.MemberId);
                if (member != null)
                {
                    using var context = new FStoreContext();
                    context.Members.Update(mem);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The member does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void Remove(int memberID)
        {
            try
            {
                Member mem = GetMemberByID(memberID);
                if (mem != null)
                {
                    using var context = new FStoreContext();
                    context.Members.Remove(mem);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The member does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
