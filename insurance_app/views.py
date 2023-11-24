from django.contrib import auth
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse
from django.shortcuts import render
from django.db.models import Q
from datetime import datetime
from insurance_app.models import *
from django.contrib.auth.decorators import login_required

def main(request):
    return render(request,'index.html')

def logout(request):
    auth.logout(request)
    return render(request,"index.html")

def register(request):
    return render(request,'regindex.html')

def logincode(request):
    try:
        username=request.POST['textfield']
        password=request.POST['textfield2']
        ob=login_table.objects.get(username=username,password=password)
        if ob.type == "admin":
            ob1=auth.authenticate(username="admin",password="admin")
            if ob1 is not None:
                auth.login(request,ob1)
                request.session['lid'] = ob.id

            return HttpResponse('''<script>window.location="/AgencyHome"</script>''')
        elif ob.type == "user":
            request.session['lid']=ob.id
            ob1 = auth.authenticate(username="admin", password="admin")
            if ob1 is not None:
                auth.login(request, ob1)
            return HttpResponse('''<script>window.location="/UserHome"</script>''')
    except Exception as e:
        print (e)
        return HttpResponse('''<script>alert("Invalid username or password");window.location="/"</script>''')


def UserReg(request):
    first_name=request.POST["textfield2"]
    last_name=request.POST["textfield3"]
    place=request.POST["textfield4"]
    post=request.POST["textfield5"]
    pin=request.POST["textfield"]
    phone=request.POST["textfield6"]
    email=request.POST["textfield7"]

    photo=request.FILES["file"]
    fs=FileSystemStorage()
    fsave=fs.save(photo.name,photo)

    proof=request.FILES["file2"]
    fs1=FileSystemStorage()
    fsave1=fs1.save(proof.name,proof)

    username=request.POST["textfield8"]
    password=request.POST["textfield9"]


    ob=login_table()
    ob.username=username
    ob.password=password
    ob.type="user"
    ob.save()


    aob=user_table()
    aob.first_name=first_name
    aob.last_name=last_name
    aob.place=place
    aob.post=post
    aob.pin=pin
    aob.phone=phone
    aob.email=email
    aob.photo=fsave
    aob.proof=fsave1
    aob.LOGIN=ob
    aob.save()
    return HttpResponse('''<script>alert("successfully Registered");window.location="/"</script>''')


@login_required(login_url='/')

def AdminHome(request):
    return render(request,'Admin/adminindex.html')


@login_required(login_url='/')


def usersearch(request):
    txt=request.POST['textfield50']
    ob=user_table.objects.filter(Q(first_name__icontains=txt) | Q(last_name__icontains=txt))
    return render(request, 'admin/view users.html',{'val': ob,'t':txt})
@login_required(login_url='/')

def ViewCompSendReply(request):
    ob=complaints_table.objects.all()
    return render(request,'admin/view complaint and send reply.html',{'val':ob})
@login_required(login_url='/')
def compsearch(request):
    dt = request.POST["textfield50"]
    ob = complaints_table.objects.filter(date__icontains=dt)
    return render(request,'admin/view complaint and send reply.html',{'val':ob,'t':dt})
@login_required(login_url='/')
def sendreply(request,id):
    request.session['cid']=id
    return render(request, 'admin/send reply.html')

@login_required(login_url='/')
def sendcreply(request):
    rep = request.POST["textarea"]
    ob = complaints_table.objects.get(id=request.session['cid'])
    ob.reply=rep
    ob.save()
    return HttpResponse('''<script>alert("Replied");window.location="/ViewCompSendReply#about"</script>''')
@login_required(login_url='/')

def viewreq(request):
    ob1=policy_table.objects.all()
    ob=ReqPolicy_table.objects.all()
    return render(request,'admin/view req from users and update sts.html',{'val':ob,'val1':ob1})
@login_required(login_url='/')
def research(request):
    print(request.POST)
    pp = request.POST["select"]
    ob = ReqPolicy_table.objects.filter(POLICY__id=pp)
    ob1 = policy_table.objects.all()
    return render(request, 'admin/view req from users and update sts.html', {'val': ob, 'val1': ob1,"t":int(pp)})
@login_required(login_url='/')
def acceptreq(request,id):
    ob = ReqPolicy_table.objects.get(id=id)
    print(ob)
    ob.status="Accepted"
    ob.save()
    return HttpResponse('''<script>alert("Accepted");window.location="/viewreq#about"</script>''')
@login_required(login_url='/')
def rejectreq(request,id):
    ob = ReqPolicy_table.objects.get(id=id)
    ob.status="Rejected"
    print(ob)
    ob.save()
    return HttpResponse('''<script>alert("Rejected");window.location="/viewreq#about"</script>''')
@login_required(login_url='/')

def ViewFeed(request):
    ob=feedback_table.objects.all()
    return render(request,'admin/view feedback.html',{'val':ob})
@login_required(login_url='/')
def feedsearch(request):
    dt = request.POST["textfield50"]
    ob = feedback_table.objects.filter(date__icontains=dt)
    return render(request, 'admin/view feedback.html', {'val': ob,"t":dt})
@login_required(login_url='/')



def ViewRating(request):
    ob=rating_table.objects.all()
    return render(request,'admin/view rating.html',{'val':ob})
@login_required(login_url='/')
def ratingsearch(request):
    dt = request.POST["textfield50"]
    ob=rating_table.objects.filter(date__icontains=dt)
    return render(request,'admin/view rating.html',{'val':ob,'t':dt})
@login_required(login_url='/')
def ViewUsers(request):
    return render(request,'admin/view users.html')
@login_required(login_url='/')
def viewclaim(request):
    ob=claim_table.objects.all()
    return render(request, 'admin/view claim request and approve.html',{'val':ob})
@login_required(login_url='/')
def acceptclaim(request,id):
    ob=claim_table.objects.get(id=id)
    ob.status="Accepted"
    ob.save()
    return HttpResponse('''<script>alert("Accepted");window.location="/viewclaim#about"</script>''')
@login_required(login_url='/')

def rejectclaim(request,id):
    ob=claim_table.objects.get(id=id)
    ob.status="Rejected"
    ob.save()
    return HttpResponse('''<script>alert("Rejected");window.location="/viewclaim#about"</script>''')
@login_required(login_url='/')
def claimsearch(request):
    dt=request.POST['textfield50']
    ob = claim_table.objects.filter(date=dt)
    return render(request, 'admin/view claim request and approve.html',{'val':ob,'t':dt})
@login_required(login_url='/')
def viewuser(request):
    ob=user_table.objects.all()
    return render(request, 'admin/view users.html',{'val':ob})
@login_required(login_url='/')



def AgencyHome(request):
    return render(request, 'admin/adminindex.html')
@login_required(login_url='/')
def AddManage_policy(request):
    ob=policy_table.objects.all()
    return render(request, 'admin/Add and manage policy.html',{'val':ob})
@login_required(login_url='/')
def Add_policy(request):
    return render(request, 'Add policy.html')
@login_required(login_url='/')

def UserHome(request):
    return render(request,'user/userindex.html')
@login_required(login_url='/')
def AddClaim(request):
    ob=ReqPolicy_table.objects.filter(USER__LOGIN__id=request.session['lid'],status='Accepted')
    return render(request,'user/Add claim req.html',{'val':ob})
@login_required(login_url='/')
def AddCommplaint(request):
    return render(request,'user/Add complaint.html')
@login_required(login_url='/')
def csend(request):
    co=request.POST['textarea']
    ob=complaints_table()
    ob.complaint=co
    ob.USER=user_table.objects.get(LOGIN__id=request.session['lid'])
    ob.date=datetime.today()
    ob.reply="pending"
    ob.save()
    return HttpResponse('''<script>alert("Succesfully Send");window.location="/SendComplaints_ViewReply#about"</script>''')
@login_required(login_url='/')


def SendComplaints_ViewReply(request):
    ob=complaints_table.objects.filter(USER__LOGIN__id=request.session['lid'])
    return render(request,'user/send complaints and view reply.html',{'val':ob})
@login_required(login_url='/')
def SendFeedback(request):
    return render(request,'user/send feedback.html')
@login_required(login_url='/')
def feed(request):
    fee=request.POST['textarea']
    ob=feedback_table()
    ob.feedback=fee
    ob.USER=user_table.objects.get(LOGIN__id=request.session['lid'])
    ob.date=datetime.today()
    ob.save()
    return HttpResponse('''<script>alert("successfully Send");window.location="/UserHome#about"</script>''')
@login_required(login_url='/')


def Sendrating(request):
    return render(request,'user/send rating.html')
@login_required(login_url='/')
def rate(request):
    ra=request.POST['select']
    ob=rating_table()
    ob.rating=ra
    ob.USER = user_table.objects.get(LOGIN__id=request.session['lid'])
    ob.date = datetime.today()
    ob.save()
    return HttpResponse('''<script>alert("successfully Send");window.location="/UserHome#about"</script>''')
@login_required(login_url='/')
def ViewClaimReq(request):
    # obj=ReqPolicy_table.objects.filter(USER__LOGIN__id=request.session['lid'],status="Accepted")
    ob=claim_table.objects.filter(USER__LOGIN__id=request.session['lid'])
    return render(request,'user/view claim and req status.html',{'val':ob})
@login_required(login_url='/')
def sclaim(request):
    dt=request.POST['textfield50']
    ob=claim_table.objects.filter(USER__LOGIN__id=request.session['lid'],date__icontains=dt)
    return render(request,'user/view claim and req status.html',{'val':ob,"t":dt})
@login_required(login_url='/')
def ViewPolicy_SendReq(request):
    ob=policy_table.objects.all()
    return render(request,'user/view policy and send req.html',{'val':ob})

@login_required(login_url='/')
def ViewPolicy_Search(request):
    pname=request.POST['pol']
    ob=policy_table.objects.filter(name__icontains=pname)
    return render(request, 'user/view policy and send req.html', {'val': ob})



@login_required(login_url='/')
def ViewPolicyReqSts(request):
    ob=ReqPolicy_table.objects.filter(USER__LOGIN__id=request.session['lid'])
    return render(request,'user/view policy req sts.html',{'val':ob})
@login_required(login_url='/')
def Addpolicy_post(request):
    Name=request.POST["textfield"]
    Policydetails=request.POST["textfield2"]
    ob=policy_table()
    ob.name=Name
    ob.policy_detials=Policydetails
    ob.save()
    return HttpResponse('''<script>alert("successfully Added");window.location="/AddManage_policy#about"</script>''')
@login_required(login_url='/')
def addnew(request):
    claim=request.POST["textfield"]
    description=request.POST["textarea2"]
    document=request.FILES["file"]
    fs=FileSystemStorage()
    fn=fs.save(document.name,document)
    py=request.POST["select"]
    ob=claim_table()
    ob.claim=claim
    ob.description=description
    ob.document=fn
    ob.date=datetime.today()
    ob.status="pending"
    ob.USER=user_table.objects.get(LOGIN__id=request.session['lid'])
    ob.POLICY=policy_table.objects.get(id=py)
    ob.save()
    return HttpResponse('''<script>alert("successfully Added");window.location="/ViewClaimReq#about"</script>''')

@login_required(login_url='/')
def editpolicy(request,id):
    request.session['pid']=id
    ob=policy_table.objects.get(id=id)
    return render(request,'admin/edit policy.html',{'val':ob})
@login_required(login_url='/')
def editpolicy_post(request):
    Name = request.POST["textfield"]
    Policydetails = request.POST["textfield2"]
    ob = policy_table.objects.get(id=request.session['pid'])
    ob.name = Name
    ob.policy_detials=Policydetails
    ob.save()
    return HttpResponse('''<script>alert("successfully Added");window.location="/AddManage_policy#about"</script>''')
@login_required(login_url='/')

def dltpolicy(request,id):
    ob = policy_table.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script>alert("successfully Deleted");window.location="/AddManage_policy#about"</script>''')
@login_required(login_url='/')
def policysearch(request):
    txt=request.POST["textfield50"]
    ob=policy_table.objects.filter(name__icontains=txt)
    return render(request, 'admin/Add and manage policy.html', {'val': ob,'t':txt})
@login_required(login_url='/')

def sndrequest(request,id):
    z=ReqPolicy_table.objects.filter(USER__LOGIN__id=request.session['lid'],POLICY__id=id)
    if len(z) == 0:
        ob=ReqPolicy_table()
        ob.POLICY=policy_table.objects.get(id=id)
        ob.USER=user_table.objects.get(LOGIN__id=request.session['lid'])
        ob.status="pending"
        ob.date=datetime.today()
        ob.save()
        return HttpResponse('''<script>alert("Requested");window.location="/ViewPolicy_SendReq#about"</script>''')
    else:
        return HttpResponse('''<script>alert("Already requested");window.location="/ViewPolicy_SendReq#about"</script>''')

@login_required(login_url='/')
def csearch(request):
    dt=request.POST['textfield50']
    ob=complaints_table.objects.filter(USER__LOGIN__id=request.session['lid'],date__icontains=dt)
    return render(request, 'user/send complaints and view reply.html', {'val': ob,'t':dt})
@login_required(login_url='/')
def view_profile(request):
    ob=user_table.objects.get(LOGIN__id=request.session['lid'])
    return render(request, 'user/profile.html',{"v":ob})


def UserUpdate(request):
    first_name=request.POST["textfield2"]
    last_name=request.POST["textfield3"]
    place=request.POST["textfield4"]
    post=request.POST["textfield5"]
    pin=request.POST["textfield"]
    phone=request.POST["textfield6"]
    email=request.POST["textfield7"]

    # photo=request.FILES["file"]
    # fs=FileSystemStorage()
    # fsave=fs.save(photo.name,photo)
    #
    # proof=request.FILES["file2"]
    # fs1=FileSystemStorage()
    # fsave1=fs1.save(proof.name,proof)






    aob=user_table.objects.get(LOGIN__id=request.session['lid'])
    aob.first_name=first_name
    aob.last_name=last_name
    aob.place=place
    aob.post=post
    aob.pin=pin
    aob.phone=phone
    aob.email=email
    try:
        photo = request.FILES["file"]
        fs = FileSystemStorage()
        fsave = fs.save(photo.name, photo)
        aob.photo = fsave
    except:
        pass

    try:


        proof = request.FILES["file2"]
        fs1 = FileSystemStorage()
        fsave1 = fs1.save(proof.name, proof)
        aob.proof = fsave1
    except:
        pass



    aob.save()
    return HttpResponse('''<script>alert("Updated");window.location="/view_profile"</script>''')

