import datetime
import boto3
import json
import csv

clienteIAM = boto3.client('iam')
outputCSV  = open('test.csv', "wb")
writer = csv.writer(outputCSV, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
writerHeader = csv.DictWriter(outputCSV, fieldnames = ["Usuario"])
writerHeader.writeheader()

usuarios = clienteIAM.list_users()
gruposUsuario = dict()
inlineUserPolicies = dict()
attachedUserPolicies = dict()
inlineGroupPolicies = dict()
attachedGroupPolicies = dict()

for usuario in usuarios['Users']:
	fila = list()
	print 'Usuario: ' + usuario['UserName']
	fila.append(usuario['UserName'])
	inlineUserPolicies = clienteIAM.list_user_policies(UserName=usuario['UserName'])
	attachedUserPolicies = clienteIAM.list_attached_user_policies(UserName=usuario['UserName'])


	for attachedPolicy in attachedUserPolicies['AttachedPolicies']:
		if len(attachedPolicy):
			print attachedPolicy['PolicyName']
			fila.append(attachedPolicy['PolicyName'])
	
	if len(inlineUserPolicies['PolicyNames']):
		for inlineUserPolicy in inlineUserPolicies['PolicyNames']:
			print inlineUserPolicy
			fila.append(inlineUserPolicy)

	gruposUsuario = clienteIAM.list_groups_for_user(UserName=usuario['UserName'])


	for grupo in gruposUsuario['Groups']:
		print 'Policies del grupo: ' + grupo['GroupName']
		inlineGroupPolicies = clienteIAM.list_group_policies(GroupName=grupo['GroupName'])
		
		if inlineGroupPolicies['PolicyNames']:
			for inlineGroupPolicy in inlineGroupPolicies['PolicyNames']:
				print inlineGroupPolicy
				fila.append(inlineGroupPolicy)
		
		attachedGroupPolicies = clienteIAM.list_attached_group_policies(GroupName=grupo['GroupName'])
		for attachedGroupPolicy in attachedGroupPolicies['AttachedPolicies']:
			if len(attachedGroupPolicy):
				print attachedGroupPolicy['PolicyName']
				fila.append(attachedGroupPolicy['PolicyName'])

	print '\n'
	
	writer.writerow(fila)
