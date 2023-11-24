from django.db import models

# Create your models here.
class login_table(models.Model):
    username=models.CharField(max_length=100)
    password=models.CharField(max_length=100)
    type=models.CharField(max_length=100)

class policy_table(models.Model):
    name=models.CharField(max_length=100)
    policy_detials=models.CharField(max_length=100)

class user_table(models.Model):
    first_name=models.CharField(max_length=100)
    last_name=models.CharField(max_length=100)
    place=models.CharField(max_length=100)
    post=models.CharField(max_length=100)
    pin=models.IntegerField()
    phone=models.BigIntegerField()
    email=models.CharField(max_length=100)
    photo=models.FileField()
    proof=models.FileField()
    LOGIN=models.ForeignKey(login_table,on_delete=models.CASCADE)

class complaints_table(models.Model):
    USER=models.ForeignKey(user_table,on_delete=models.CASCADE)
    complaint=models.CharField(max_length=100)
    date=models.DateField()
    reply=models.CharField(max_length=100)

class feedback_table(models.Model):
    feedback=models.CharField(max_length=100)
    date=models.DateField()
    USER=models.ForeignKey(user_table,on_delete=models.CASCADE)

class rating_table(models.Model):
    rating=models.CharField(max_length=100)
    date=models.DateField()
    USER=models.ForeignKey(user_table, on_delete=models.CASCADE)

class claim_table(models.Model):
    claim=models.CharField(max_length=100)
    description=models.CharField(max_length=100)
    document=models.FileField()
    date=models.DateField()
    USER = models.ForeignKey(user_table,on_delete=models.CASCADE)
    POLICY=models.ForeignKey(policy_table,on_delete=models.CASCADE)
    status=models.CharField(max_length=100)

class ReqPolicy_table(models.Model):
    date=models.DateField()
    status=models.CharField(max_length=100)
    USER=models.ForeignKey(user_table, on_delete=models.CASCADE)
    POLICY=models.ForeignKey(policy_table, on_delete=models.CASCADE)

