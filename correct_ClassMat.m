function  [classmat_correct,nochixy_nextsort]=correct_ClassMat(classmat)
%���ܣ���ȫclassmat�����ͨ��
%���룺classmat  2040*2040*1��1-9������ǩ����
%�����classmat_correct  ��ȫͨ�����classmat
%      nochixy_nextsort У����classmat_correctȱͨ����λ��

    chindexmat0=[flipdim(classmat(2:13,:),1);classmat;flipdim(classmat(end-12:end-1,:),1)];
    chindexmat=[flipdim(chindexmat0(:,2:13),2),chindexmat0,flipdim(chindexmat0(:,end-12:end-1),2)];
    chindexmat_correct=chindexmat;
    bfindi=ones(344,344);
    no1xy=[];
    
    for i=1:344
        for j=1:344
            b66i=chindexmat(6*i-5:6*i,6*j-5:6*j);
            b66i_correct=b66i;
            %��b66iȱchi��λ��
            for chi=1:9
                if isempty(find(b66i==chi))==1                                
                    bfindi(i,j)=0;
                    no1xy(end+1,:)=[i,j,chi];       

                  %% ��ȱ��chi��ȷ��ch1��λ��
                    % �м�λ��ȱchi
                    if i>2 && i<343 && j>2 && j<343
                        bb55=chindexmat(6*i-17:6*i+12,6*j-17:6*j+12);

                        %25��bb5566��36��λ���ϸ�λ�ô�����1������
                        num36=zeros(1,36);                        
                        for ii=1:5
                            for jj=1:5
                                bb5566=bb55(6*ii-5:6*ii,6*jj-5:6*jj);
                                xyi=find(bb5566==chi);
                                for ij=1:length(xyi)
                                    num36(1,xyi(ij))=num36(1,xyi(ij))+1;      
                                end                    
                            end
                        end
                        [num36_max,num36_maxindex]=max(num36);

                        i_correct=mod(num36_maxindex,6);
                        if i_correct==0
                            i_correct=6;
                        end                   
                        j_correct=floor((num36_maxindex-i_correct)/6)+1;

                        %b66i_correct=b66i;
                        b66i_correct(i_correct,j_correct)=chi;        
                        chindexmat_correct(6*i-5:6*i,6*j-5:6*j)=b66i_correct;

                    end
                end
            end

        end
    end
    classmat_correct=chindexmat_correct(13:end-12,13:end-12);
    
    
    
    
    
    
    %%
    chindexmat_next0=[flipdim(classmat_correct(2:13,:),1);classmat_correct;flipdim(classmat_correct(end-12:end-1,:),1)];
    chindexmat_next=[flipdim(chindexmat_next0(:,2:13),2),chindexmat_next0,flipdim(chindexmat_next0(:,end-12:end-1),2)];
    
    nochixy_next=[];   
    for i=1:344
        for j=1:344
            b66i_next=chindexmat_next(6*i-5:6*i,6*j-5:6*j);
            %��b66iȱchi��λ��
            for chi=1:9
                if isempty(find(b66i_next==chi))==1                                
                    nochixy_next(end+1,:)=[i,j,chi];       
                end
            end
        end
    end
    
    
    if isempty(nochixy_next)==0
        [vv,inin]=sort(nochixy_next(:,3));
        nochixy_nextsort=no1xy(inin,:);

        for cxi=[1,2,343,344]
            for cxj=1:2
                nochixy_nextsort(find(nochixy_nextsort(:,cxj)==cxi),:)=[];   
            end    
        end
        
    else
        nochixy_nextsort=[];
        
    end


end