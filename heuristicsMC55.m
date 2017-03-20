%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% ALGORITHM PA2 unique/next rarest/richest/random %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
A =csvread ('amphibians2.csv');

%A = distributed(B);

% m=11000;
% n=100;
% 
% A=[[];[]];
% 
% for i = 1: m
%     
%    for j = 1 : n
%       
%    A(i,j)= randi (2,1)-1;
%        
%    end    
%     
% end


[row_sites,col_species]=size (A);

times=1;

Results = zeros(4,times);

TotalTime=0; 

for z =1 : times
  tStart = tic;    
    
    %row_sites
    
    %col_species
    
    %pause ;
    
    SiteRichness=[]; % Site richness is the number of species in each site
    
    SpeciesRange=[]; % Is the total number of sites in which a species is found
    SpeciesRarity=[]; % is 1/speciesrange
    
    RarityScore=[]; % Is the sum of rarity values SpeciesRarity[] for the species in the site.
    
    %UniqueSpecieSite=[];% if UniqueSpecieSite(i)==1 mean that this Site is a unique specie Site
    sum=0;
    
    %%@@@@@@ OUTPUT (FEATURES AND SITES) @@@@@@%%
    % Protected Species
    Features=[];
    % Protected sites
    Sites=[];
    
    %%%%%%%%%%%% OUTPUT INITIALIZATION %%%%%%%%%%%%%%%%%%%%
    
    %Initialize output of features protected
    for i = 1: col_species
        Features(i)=0;
    end
    
    %Initialize output of sites protected
    for i=  1 : row_sites
        Sites(i)=0;
    end
    
    %%%%%%%% COMPUTING METRICS %%%%%%%%%%%%
    
    for i = 1:row_sites
        
        for j = 1:col_species
            
            sum = (sum + (A(i,j)));
            
        end
        SiteRichness(i)=sum; %is the number of species in site (i)
        sum=0;
        
    end
    
    %SiteRichness
    
    sum=0;
    debug=1;
    
    for i = 1:col_species
        
        for j = 1:row_sites
            
            sum = (sum + (A(j,i)));
            
        end
        SpeciesRange(i)=sum; %Is the total number of sites in which a specie (i) is found
        
        if sum > 0
            SpeciesRarity(i)=1/sum; % is 1/speciesrange (i), 1/ the total number of sites in which a specie (i) is found
            
        else
            SpeciesRarity(i)=0;
            
        end
        sum=0;
    end
    
    %SiteRichness
    
    %SpeciesRange
    
    %SpeciesRarity
    
    sum=0;
    debug=1;
    
    %%%%%%%%%%%%%%%RarityScore creating process
    
    for i = 1:row_sites
        
        for j = 1:col_species
            
            if A(i,j)==1
                sum = sum + SpeciesRarity(j);
            end
        end
        RarityScore(i)=sum; %Is the sum of rarity values SpeciesRarity[] for the species in the site i.
        sum=0;
        
    end
    
    debug=1;
    %RarityScore
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%% RULE 1 UNIQUE Features %%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    SpeciesUnique=[];
    
    for i = 1 : col_species
        SpeciesUnique(i)=0;
    end
    
    for i= 1: col_species
        
        %SpeciesUnique(i) =1 if the specie i is unique, just represented in one
        %grid Site
        if SpeciesRange(i)==1
            % disp ('UNIQUE SPECIES')
            %  i
            SpeciesUnique(i)=1;
            %NOUpdate Features here
            %Features(i)=Features(i)+1;
            
        end
        
    end
    
    %SpeciesUnique
    %%%%%%% UPDATE Sites and Features from UNIQUE RULE from SpeciesUnique(i)
    
    MSC=0;
    RuleLoopUniqueNumber=0;
    
    %while MSC==0
    
    for i = 1 : col_species
        if MSC == 1
            break;
        end
        if SpeciesUnique(i)==1 && MSC==0 %%%%% 1 FIND SPECIES UNIQUE %%%%%
            RuleLoopUniqueNumber=RuleLoopUniqueNumber+1;
            for j = 1 : row_sites
                if MSC == 1
                    break;
                    %  disp ('break');
                    %MSC
                end
                if A(j,i)==1  %%%%% 2 FIND SITE WHERE SPECIES UNIQUE %%%%%
                    
                    Sites(j)=Sites(j)+1;
                    j
                    for k = 1 : col_species
                        if A(j,k)==1
                            Features(k)=Features(k)+1; %%%%% 3 PROTECT UNIQUE SPECIES IN THE CELL AND THE REST OF SPECIES IN THE CELL %%%%%
                        end
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%% ROUTINE FOR KNOW IF MSC HAVE BEEN ACHIEVED %%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    for k=1:col_species
                        
                        if Features(k)==0 %at least one specie is unprotected
                            MSC=0;
                            break;
                        else
                            MSC=1;
                            
                        end
                        
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                end
                
            end
            
        end
        
    end
    
    
    
    %end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%% FINISH RULE 1 UNIQUE Features %%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % A
    % Sites
    % Features
    
    
    RuleLoopNumber=0;
    
    
    %   Features
    
    
    LoopCounter=0;
    
    MSC=0;
    
    while MSC==0
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%% RULE 2 NEXT RAREST %%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% UPDATE INITIAL METRICS WITH ONLY UNDER-REPRESENTED SPECIES %%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%SPECIESRANGE AND SPECIESRARITY%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for i = 1:col_species
            
            if Features(i)==0
                for j = 1:row_sites
                    % ONLY IF THE SPECIES ARE NOT PROTECTED
                    %if Features(i)==0
                    sum = (sum + (A(j,i)));
                    %end
                end
                SpeciesRange(i)=sum; %Is the total number of sites in which a specie (i) is found
                
                if sum > 0
                    SpeciesRarity(i)=1/sum; % is 1/speciesrange (i), 1/ the total number of sites in which a specie (i) is found
                    
                else
                    SpeciesRarity(i)=0;
                    
                end
                
            else
                
                SpeciesRange(i)=0; %Is the total number of sites in which a specie (i) is found
                SpeciesRarity(i)=0; % is 1/speciesrange (i), 1/ the total number of sites in which a specie (i) is found
                
            end
            sum=0;
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%SITERICHNESS%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for i = 1:row_sites
            
            if Sites(i)==0
                
                for j = 1:col_species
                    
                    if Features(j)==0 %%%% FUNDAMENTAL!!!!!!!!
                        sum = (sum + (A(i,j)));
                    end
                end
                SiteRichness(i)=sum; %is the number of species in site (i)
                sum=0;
                
            else
                
                SiteRichness(i)=0;
                
            end
            
        end
        
        % SpeciesRange
        %
        % SpeciesRarity
        %
        % SiteRichness
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%SEARCH ALL Sites OF THE NEXT RAREST SPECIE/S%%%%%%%%%%%%%%%%%%%%%
        %%%% FIRST STEP: SEARCH ALL THE SPECIE/S WITH THE MAXIMUM RARITY VALUE %%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%% SEARCH THE MAXIMUM RARITY VALUE %%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        MaxSpeciesRarity=0;
        
        for i = 1:col_species
            
            if SpeciesRarity (i) >= MaxSpeciesRarity
                MaxSpeciesRarity = SpeciesRarity (i);
            end
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% FOR ALL SPECIE/S WITH MAXIMUM RARITY CHOOSE ¡¡ALL!! Sites WHERE ¡¡THEY!! ARE %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        SitesWhereNextRarestSpecies=[];
        
        
        for i = 1: row_sites
            SitesWhereNextRarestSpecies(i)=0;
        end
        
        
        for i = 1:col_species
            
            if SpeciesRarity(i) == MaxSpeciesRarity
                
                for j = 1: row_sites
                    
                    if SiteRichness(j) > 0 && A(j,i)==1  && Features(i)==0%%%% SPECIES i NOT PROTECTED
                        
                        SitesWhereNextRarestSpecies(j)=1;
                        
                    end
                    
                end
                
            end
            
            
        end
        
        %     SiteRichness
        %     SitesWhereNextRarestSpecies
        
        NumberOfSitesWithNextRarestSpecies=0;
        
        for i = 1: row_sites
            if SitesWhereNextRarestSpecies(i)==1
                NumberOfSitesWithNextRarestSpecies=NumberOfSitesWithNextRarestSpecies+1;
                SiteWithNextRarestSpecies=i;
            end
            
        end
        
        %     NumberOfSitesWithNextRarestSpecies
        
        %%%%%%% SOLVE TIES BETWEEN Sites WITH NEXT RAREST SPECIE/S USING SITERICHNESS
        
        
        SitesWhereNextRarestSpeciesAndRichestSite = [];
        
        for i=1 : row_sites
            SitesWhereNextRarestSpeciesAndRichestSite(i)=0;
        end
        
        MaxSiteRichness=0;
        SiteWhereMaxSiteRichness=0;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%CALCULATE THE MAX RICHNESS SITE%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for i=1 : row_sites
            
            if SiteRichness(i) >= MaxSiteRichness && SitesWhereNextRarestSpecies(i)==1
                MaxSiteRichness=SiteRichness(i);
                %SiteWhereMaxSiteRichness=i
            end
        end
        
        %%SitesWhereRichestSite = [];
        
        NumberOfSitesWithRichestSite=0;
        
        
        for i=1 : row_sites
            
            if SiteRichness(i) >= MaxSiteRichness && SitesWhereNextRarestSpecies(i)==1
                SitesWhereNextRarestSpeciesAndRichestSite(i)=1;
                NumberOfSitesWithRichestSite=NumberOfSitesWithRichestSite+1;
                SiteWithMaxSiteRichness=i;
                %SiteWhereMaxSiteRichness=i
            end
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%NOT TIES IN RULE 2 AND NOT TIES IN RULE 3%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        if  NumberOfSitesWithNextRarestSpecies == 1
            
            %SiteWithNextRarestSpecies
            if MSC == 1
                break;
                %  disp ('break');
                %MSC
            end
            if Sites(SiteWithNextRarestSpecies)==0 %% IF THE CELL IS UNPROTECTED
                
                Sites(SiteWithNextRarestSpecies)=Sites(SiteWithNextRarestSpecies)+1;  %% PROTECT CELL
                %SiteWithNextRarestSpecies
                
                for k = 1 : col_species
                    if A(SiteWithNextRarestSpecies,k)==1
                        Features(k)=Features(k)+1;   %%PROTECT SPECIES
                    end
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%% ROUTINE FOR KNOW IF MSC HAVE BEEN ACHIEVED %%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                for k=1:col_species
                    
                    if Features(k)==0 %at least one specie is unprotected
                        MSC=0;
                        break;
                    else
                        MSC=1;
                        
                    end
                    
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            end
            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% TIES IN RULE 2 AND NOT TIES IN RULE 3 %%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        if NumberOfSitesWithNextRarestSpecies > 1 && NumberOfSitesWithRichestSite ==1
            
            %SiteWithMaxSiteRichness
            
            
            if MSC == 1
                break;
                %  disp ('break');
                %MSC
            end
            if Sites(SiteWithMaxSiteRichness)==0 %% IF THE CELL IS UNPROTECTED
                
                Sites(SiteWithMaxSiteRichness)=Sites(SiteWithMaxSiteRichness)+1;  %% PROTECT CELL
                %   SiteWithMaxSiteRichness
                for k = 1 : col_species
                    if A(SiteWithMaxSiteRichness,k)==1
                        Features(k)=Features(k)+1;   %%PROTECT SPECIES
                    end
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%% ROUTINE FOR KNOW IF MSC HAVE BEEN ACHIEVED %%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                for k=1:col_species
                    
                    if Features(k)==0 %at least one specie is unprotected
                        MSC=0;
                        break;
                    else
                        MSC=1;
                        
                    end
                    
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            end
            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        r=0;
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%% TIES IN RULE 2 AND TIES IN RULE 3 %%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if NumberOfSitesWithNextRarestSpecies > 1 && NumberOfSitesWithRichestSite >1
            
            r = randi(NumberOfSitesWithRichestSite,1,1);
            count=0;
            siteprotected=0;
            
            for i = 1 : row_sites
                
                if  SitesWhereNextRarestSpeciesAndRichestSite(i)==1
                    count=count+1;
                    if r==count
                        siteprotected=i;
                    end
                end
                
            end
            
            if MSC == 1
                break;
                %  disp ('break');
                %    MSC
            end
            if Sites(siteprotected)==0 %% IF THE CELL IS UNPROTECTED
                
                Sites(siteprotected)=Sites(siteprotected)+1;  %% PROTECT CELL
                siteprotected;
                
                for k = 1 : col_species
                    if A(siteprotected,k)==1
                        
                        Features(k)=Features(k)+1;   %%PROTECT SPECIES
                    end
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%% ROUTINE FOR KNOW IF MSC HAVE BEEN ACHIEVED %%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                for k=1:col_species
                    
                    if Features(k)==0 %at least one specie is unprotected
                        MSC=0;
                        break;
                    else
                        MSC=1;
                        
                    end
                    
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            end
            
            
            
        end
        
        RuleLoopNumber=RuleLoopNumber+1;
        
    end
    
    % NumberOfSitesWithRichestSite
    % SitesWhereNextRarestSpeciesAndRichestSite
    % siteprotected
    
    
    
    %Sites
    
    NumberOfSitesProtected=0;
    for i=1 : row_sites
        if Sites(i) >= 1
            NumberOfSitesProtected=NumberOfSitesProtected+1;
            %i
            %Sites(i)
            
        end
    end
    
    %Features
    
    Loops=0;
    
    
    %RuleLoopUniqueNumber
    %RuleLoopNumber
    Loops = RuleLoopUniqueNumber + RuleLoopNumber;
    %Loops
    
    %NumberOfSitesProtected
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%% VERIFICATION OF THE RESULTS %%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    FeaturesVerification = [];
    
    for i=1: col_species
        
        FeaturesVerification(i)=0;
    end
    
    sum=0;
    for i=1: col_species
        
        for j=1: row_sites
            if Sites(j)>=1
                
                sum=sum + A(j,i);
                
            end
            
        end
        
        FeaturesVerification(i)=sum;
        sum=0;
        
    end
    
     
    %FeaturesVerification
    
    %Features
    
    ResultVerified=isequal(FeaturesVerification,Features);
    
    %ResultVerified
    


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% FUNCTION FOR SEARCH REDUNDANT SITES %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% not look for cells where unique species exists%%%

CandidateRedundantSites=zeros(1,row_sites);


for i= 1:row_sites %for each site
    
    IsARedundantSite=1;
      
    if Sites (i) >=1
        
        %&& UniqueSpecieSite(i)==0 % if cell i is protected (early selected sites)
        for j= 1:col_species % for each species protected
            
            if A(i,j)==1 && (Features(j)-1)==0 % if specie j is represented in cell i and deleting cell i result in an unprotection of specie j
                
                IsARedundantSite=0;
                break; % then features target is not achieved => Site is
                % not redundant stop analyzing redundancy in this site
                
            end
            
        end
        
        if IsARedundantSite==1
            
            CandidateRedundantSites(i)==1
            
        end
        
    end
    
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%PRINT REDUNDANT%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:row_sites
   
    if CandidateRedundantSites (i) >= 1
        disp ('redundant')
        i
    end
        
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% OTHER OUTPUTS%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
    Results(1,z)=NumberOfSitesProtected;
    Results(2,z)=Loops;
    Results(3,z)=ResultVerified;
    tElapsed = toc(tStart); 
    Results(4,z)=tElapsed;
 
    TotalTime= TotalTime + tElapsed;


end

Results
TotalTime

%%%%%%%%%%%%%%%%%%
%%% PRINT ZONE %%%
%%%%%%%%%%%%%%%%%%

%Features
% for i=1 : row_sites
%         if Sites(i) >= 1
%             i
%             %i
%             %Sites(i)
%             
%         end
%     end




% if FeaturesTargetNotAchieved==0 %if Features target continue at MSC level, unprotect Cell i (Redudndan cell)
%     CandidateRedundantSites (i) = 1;
%     %update features for reduce
% %         for j= 1:row
% %             if A(i,j)==1
% %                 Features(j)=Features(j)-1;
% %             end
% %         end
%     end
% 
% end






% %%%% not look for cells where unique species exists%%%
%
% for i= 1:row %for each site
%
%     FeaturesTargetNotAchieved=0;
%
%     if FeaturesTargetNotAchieved==0 && Sites (i)==1 %&& UniqueSpecieSite(i)==0 % if cell i is protected (early selected sites)
%         for j= 1:col % for each species protected
%
%             if A(i,j)==1 % if specie j is represented in cell i
%                 if    (Features(j)-1)==0 % if deleting cell i result in an unprotection of specie j
%                     FeaturesTargetNotAchieved=1; % then features target is not achieved => Site is not redundant
%                     break; % stop searching sites
%
%
%                 end
%
%             end
%         end
%     end
%     if FeaturesTargetNotAchieved==0 %if Features target continue at MSC level, unprotect Cell i (Redudndan cell)
%         Sites(i) = 0;
%         %update features for reduce
%         for j= 1:row
%             if A(i,j)==1
%                 Features(j)=Features(j)-1;
%             end
%         end
%     end
%
% end
